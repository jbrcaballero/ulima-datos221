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

//Buscar un empleado especifico
db.employees.find({codigo: 400});
db.employees.find({nombre: "Ana Velarde"});

//Proyección: Solo los datos de nombre y salario
db.employees.find({codigo: 400}, {nombre: 1, salario: 1});

//Proyección: Excluir el dato del salario
db.employees.find({codigo: 400}, {salario: 0});

//Busqueda con varias condiciones
db.employees.find({codigo: 400, salario: 6700});

//Condiciones OR
db.employees.find({$or: [{codigo: 400}, {codigo: 200, nombre: "Ana Velarde"}]});

//Busqueda con listas (IN)
db.employees.find({codigo: {$in: [500, 600, 700]}});


//Busqueda con comparacion (numeros)

//Empleados con salario menor o igual que 4900
db.employees.find({salario: {$lte: 4900}});

//Mostrar empleados cuyo código no sea 100 ni 600 ni 900 y tengan salario mayor o igual que 10000.
db.employees.find({codigo: {$nin: [100, 600, 900]}, salario: {$gte: 10000}});

//Mostrar empleados con salario en el intervalo [6000, 11000]. Excluya al empleado 100
db.employees.find({salario: {$gte: 6000, $lte: 11000}, codigo: {$ne: 100}}); 


//Actualizaciones

//Documento completo
db.employees.update({codigo: 400}, {codigo: 400, nombre: "Cesar W. Chang", salario: 7000, ciudad: "Lima"});

//Campos especificos
//Actualice a 9000 el salario del empleado de codigo 600 y actualizar su valor de ciudad a "Chiclayo"
db.employees.update({codigo: 600}, {$set: {salario: 9000, ciudad: "Chiclayo", region: "Norte"}});


//Eliminar
//Eliminar todos los documentos asociados a empleados con codigo menor que 100
db.employees.remove({codigo: {$lte: 200}});


//Eliminar el registro de codigo 700 y nombre "Adriana Quiroz"
db.employees.remove({codigo: 700, nombre: "Adriana Quiroz"});


//Eliminar los registros de empleados con salario > 10000 y ciudades "Lima" o "Arequipa"
db.employees.remove({salario: {$gt: 10000}, ciudad: {$in: ["Lima", "Arequipa"]}});


//Eliminar todos los documentos
db.employees.remove({});

//Eliminar la coleccion
db.employees.drop();



//Uso de Javascript
cantidad = db.employees.count();
print("La cantidad de empleados es: " + cantidad);

doc_empleado = {codigo: 500, nombre: "Maria Vargas", salario: 12500, departamento: "IT"};
db.employees.insert(doc_empleado);

for (i = 1; i < 100; i++){
    db.employees.insert({codigo: i, nombre: "Empleado" + i, salario: 5000, departamento: "Sales"});
}

function obtenerDocumento(nomPersona, apePersona){

    res = {nombre: nomPersona, apellido : apePersona};

    return res;

}


db.prueba.insert(obtenerDocumento("Ana", "Tang"));



 

