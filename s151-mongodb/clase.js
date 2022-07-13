//Crear (o conectarse a) una base de datos desde consola
use db005

//Agregar un documento a una coleccion
db.employees.insert({codigo: 300, nombre: "Juan Perez"});
db.employees.insert({codigo: 200, nombre: "Ana Velarde"});
db.employees.insert({codigo: 400, nombre: "Cesar Chang", salario: 6700});

db.employees.insert({codigo: 500, nombre: "Steven King", salario: 9000, ciudad: "Lima"});

db.employees.insert({codigo: 600, nombre: "Pedro Zarate", salario: 8600, ciudad: "Tacna"});

db.employees.insert({codigo: 700, nombre: "Adriana Quiroz", salario: 12000, ciudad: "Arequipa"});

db.employees.insert({codigo: 800, nombre: "Maria Valverde", salario: 11500, ciudad: "Lima"});
db.employees.insert({codigo: 900, nombre: "Pedro Zurita", salario: 4500, ciudad: "Lima"});



//Mostrar todos los empleados
db.employees.find();


//Cantidad de documentos en la coleccion

db.employees.find().count();





