--ilk önce veritabanı sistemi PostgreSQL kurulmalıdır.
--daha sonra yeni bir veritabanı açılır ve ve PostGIS uzantısı eklenir
--BBBike sitesinden eklenen shapefile verileri QGIS e yüklenir ve orada işlenir.
--QGISte işlemler yapıldıktan sonra PostGIS'e yollanan veriye aşağıdaki işlemler uygulanabilir.

------------------------------------------------------------------------------------------------

--points_3dgeom tablosunun hazırlanması için kullanılan queryler

create table points_3dgeom as (select * from "LAST_POINTS");
--"LAST_POINTS" tablosunu duplicate etmek için

delete from points_3dgeom;
--tüm kayıtları silmek için

alter table points_3dgeom drop column geom;
--eski POINT tipi geometri column ı artık işe yaramaz, onu droplamak için

SELECT Find_SRID('public','points_3dgeom','geom');
--sıradaki sorgu için srid değerinin bilinmesi gerekir.

select AddGeometryColumn ('public','points_3dgeom','geom',4326,'POINTM',3);
--yeni istenen özelliklere göre geometri column ı, X Y ve M şeklinde 
--3 boyutu olacaktır ve POINTM tipindedir. 4326 önceki satırdaki sorgu sonucundan alınmıştır.

--artık geom değeri değiştirmeyi test edelim ve sonra tabloya ekleyelim

select fid, osm_id, name, geom,
	ST_MakePointM(ST_X(geom), ST_Y(geom), (select extract (EPOCH FROM timestamp)))
from "LAST_POINTS"
--ST_MakePointM fonksiyonunun kullanımı. istenile sayıda nümerik değer alan bir fonksiyondur aldığı
--değer kadar boyutta geometri üretir. M koymasaydık son değeri Z boyutu yapardı, bu da istemediğimiz
--bir durumdur. burda normal geom ve yeni geom u yan yana sorgulayarak değiştiğini gözlemleriz
	
insert into points_3dgeom
(fid, osm_id, name, type, distance, angle, timestamp, geom)
	select
	fid, osm_id, name, type, distance, angle, timestamp,
	ST_MakePointM(ST_X(geom), ST_Y(geom), (select extract (EPOCH FROM timestamp)))
	from "LAST_POINTS"
--alınan bütün sonuçları yeni tabloya insert etme sorgusu
