<?php

require_once '../layouts/body_empty.php';
require_once '../conexion.php';
require_once '../functionsGeneralJS.php';
require_once 'configModule.php';

$dbh = new Conexion();
try {
    
    $cod_nivel = $_POST["codNivel"];    

    $cod_estadoreferencial = 1;
    $numeroFilas=$_POST["numero_filas"];
    
    //echo "INGRESO NORMAL";
 
    $stmtDel = $dbh->prepare("DELETE FROM nivelesconf_camposdisponibles where cod_nivelconfiguracion='$cod_nivel'");
    $stmtDel->execute();
    $flagSuccessDetail=true;
    for ($i=0;$i<$numeroFilas;$i++){
        
        $campoInsert="";
        $ordenInsert=0;

        if(isset($_POST["campo".$i])){
            $campoInsert=$_POST["campo".$i];
            $ordenInsert=$_POST["orden".$i];
        }

        if($campoInsert!=0 || $campoInsert!=""){
            $sqlInsert="INSERT INTO nivelesconf_camposdisponibles(cod_nivelconfiguracion, cod_campodisponible, orden) values ($cod_nivel, $campoInsert, $ordenInsert)";
            //echo $sqlInsert."<br>";
            $stmt = $dbh->prepare($sqlInsert);
            $flagSuccess=$stmt->execute();
            if($flagSuccess==false){
                $flagSuccessDetail=false;
            }
        }        
    }

    if($flagSuccessDetail==true){
        showAlertSuccessError(true,$urlList);   
    }else{
        showAlertSuccessError(false,$urlList);
    }
    
    } catch(PDOException $ex){
        //manejar error
        echo "Un error ocurrio".$ex->getMessage();
    }
?>