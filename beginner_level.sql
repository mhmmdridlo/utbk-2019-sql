--- Level Beginner

-- Tampilkan semua program studi dengan kapasitas lebih dari 60
select nama_prodi "Nama Program Studi", kapasitas "Kapasitas"
from program_studi
where kapasitas > 60


-- Tampilkan nama universitas yang mengandung kata MALIK
select nama_universitas "Nama Universitas"
from universitas
where nama_universitas like '%MALIK%'


-- Berapa banyak program studi yang dimiliki oleh setiap universitas?
select u.nama_universitas "Nama Universitas", count(ps.id_prodi) "Jumlah Program Studi"
from universitas u join program_studi ps on u.id_universitas = ps.id_universitas
group by u.nama_universitas 
order by u.nama_universitas


-- Tampilkan universitas yang memiliki jumlah program studi lebih dari 10
select u.nama_universitas 'Nama Universitas', count(ps.id_prodi) "Jumlah Program Studi"
from universitas u join program_studi ps on u.id_universitas = ps.id_universitas
group by u.nama_universitas
having count(ps.id_prodi) > 10
order by "Jumlah Program Studi" DESC


-- Tampilkan 5 universitas pertama berdasarkan urutan nama universitas (A-Z)
select nama_universitas "Nama Universitas"
from universitas
order by nama_universitas 
limit 5


-- Tampilkan semua program studi dari universitas yang memiliki id_universitas 111, 112, atau 113
select id_universitas "ID Universitas", nama_prodi "Nama Prodi" 
from program_studi
where id_universitas in(111,112,113)


-- Tampilkan semua pengguna yang memilih universitas bukan 521 atau 355 sebagai pilihan kedua
select id_pil2_universitas "ID Pilihan Kedua", id_user "ID Pengguna"
from skor_saintek 
where id_pil2_universitas not in(521,355)


-- Tampilkan 10 pengguna dengan nilai matematika tertinggi 
select id_user "ID Pengguna", score_mat "Score Matematika"
from skor_saintek
order by score_mat desc
limit 10


-- Berapa rata-rata nilai matematika (score_mat) untuk setiap universitas pilihan pertama (id_pil1_universitas)
select sa.id_pi1_universitas "ID Pilihan Pertama", u.nama_universitas "Nama Universitas", round(avg(sa.score_mat)) "Nilai Rata-Rata Matematika"
from skor_saintek sa join universitas u on sa.id_pi1_universitas = u.id_universitas 
group by sa.id_pi1_universitas, u.nama_universitas 



-- Tampilkan id_pil1_universitas yang memiliki rata-rata nilai matematika (score_mat) lebih dari 600
select sa.id_pi1_universitas "ID Pilihan Pertama", u.nama_universitas "Nama Universitas", round(avg(sa.score_mat)) "Nilai Rata-Rata Matematika > 600"
from skor_saintek sa join universitas u on sa.id_pi1_universitas = u.id_universitas 
group by sa.id_pi1_universitas, u.nama_universitas 
having round(avg(sa.score_mat)) > 600
