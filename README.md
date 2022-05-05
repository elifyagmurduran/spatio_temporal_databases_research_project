# spatio_temporal_databases_research_project
 
Projede PostgreSQL ve QGIS kullanılmıştır ve PostGIS uzantısından faydalanılmıştır.

Proje ilk adımda QGIS'te başlatılır. Database.txt de verilen linkten verimizi indirmemiz gerekir.

shapefiles dosyasında bulunan .shp dosyaları Ctrl+Shift+V, ya da Vector Bundle ile yüklenir. 
Diğer dosyaların pakette bulunması gerekmektedir, yoksa .shp ler kendi başına çalışmaz. Ancak
hepsinin beraber yüklenmesi aynı layerın tekrar tekrar yüklenmesine sebep olmaktadır. 
Bu nedenle sadece .shp lerin yüklendiğine dikkat ediniz.

Daha sonra geopackages dosyasında bulunan geopackage ları yükleyebilirsiniz. Bunlar proje sırasında kendi
ürettiğimiz sentetik veri setlerini içermektedir.

Buradaki işlemleri inceledikten sonra veriyi PostGIS'e yollayarak Run.txt deki işlemleri 
inceleyebilirsiniz. Burada yeni bir 3d geometri tablosu oluşturma işlemleri bulunmaktadır.

Son olarak Code dosyasındaki queries.txt den performans analizi sorgularını inceleyebilirsiniz.