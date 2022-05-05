
--indexleme sorguları
--aşağıdaki sorgular ile explain analyze sonuçlarımızı kendiniz test edebilirsiniz.

explain analyze 
select name, ST_AsText(geom)
from points_3dgeom
where  ST_3DDWithin(
	points_3dgeom.geom,
	ST_GeomFromEWKT('SRID=4326;POINT M (10414163.086019203 4541883.334645825 1643140800)'),
	2589)
--analizde kullanılan ana query
create index threedindex on points_3dgeom using BRIN(geom)
create index threedindex on points_3dgeom using GIST(geom)
create index threedindex on points_3dgeom using SPGIST(geom)
drop index threedindex
--index ekleme ve droplama sorguları
