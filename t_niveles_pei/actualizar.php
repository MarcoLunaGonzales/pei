<?php

require_once '../layouts/body_empty.php';
require_once '../conexion.php';
require_once '../functionsGeneralJS.php';
require_once 'configModule.php';

$dbh = new Conexion();
try {
    
    $cod_nivel_padre = $_POST["codigo_nivel_padre"];  
    
    $nombre                 = $_POST["nombre"];
    $abreviatura            = $_POST["abreviatura"];
    $habilitarActividades   = $_POST["habilitar_actividades"];

    if($habilitarActividades=="on"){
        $habilitarActividades=1;
    }else{
        $habilitarActividades=0;
    }  

    // Actualización de NIVELES_PEI
    $sqlUpd="UPDATE niveles_pei 
            SET nombre = '$nombre', 
            abreviatura = '$abreviatura', 
            bandera_actividades = '$habilitarActividades' 
            WHERE codigo = '$cod_nivel_padre'";
    $stmtUpd = $dbh->prepare($sqlUpd);
    $flagSuccess=$stmtUpd->execute();
    // ACTUALIZACIÓN DE NIVELES_PEI_ADICIONALES
    $sqlDel="DELETE from niveles_pei_adicionales WHERE cod_nivelpei = '$cod_nivel_padre'";
    $stmt = $dbh->prepare($sqlDel);
    $flagSuccess=$stmt->execute();

    foreach($_POST as $nombre_campo => $valor){ 
        $asignacion = "\$" . $nombre_campo . "='" . $valor . "';";

        $cadenaBuscar='campopersonalizado';
        $posicion = strpos($nombre_campo, $cadenaBuscar);

        if ($posicion === false) {
        }else{
            list($campoInsert, $campoIndex)=explode("|",$nombre_campo);

            $sqlInsertAdicional="";
            $sqlInsertAdicional="INSERT INTO niveles_pei_adicionales (cod_nivelpei, cod_campodisponible, valor)  values ('$cod_nivel_padre', '$campoIndex', '$valor')";	    	
            $stmtInsertAdicional = $dbh->prepare($sqlInsertAdicional);	
            $flagSuccess2=$stmtInsertAdicional->execute();

            if($flagSuccess2==false){
                $flagSuccessDetail=false;
            }
        }
    }

    showAlertSuccessError($flagSuccess,$urlList);
    
    } catch(PDOException $ex){
        //manejar error
        echo "Un error ocurrio".$ex->getMessage();
    }
?>