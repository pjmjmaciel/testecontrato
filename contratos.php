<?php //require_once __DIR__ .'/db_pdo.php';
?>

<?php // $conexao = Conexao::getConnection(); 
?>
<?php $conexao =  new PDO("mysql:host=db;port=3306;dbname=testeLogica", "root", "MYSQL_ROOT_PASSWORD"); ?>

<?php $SQL = "SELECT bc.nome, conv.verba, contrato.codigo, contrato.data_inclusao,  contrato.valor, contrato.prazo FROM `Tb_contrato` contrato 
                    inner join Tb_convenio_servico cs on cs.codigo = contrato.convenio_servico
                    inner join Tb_convenio conv on conv.codigo = cs.convenio
                    inner join Tb_banco bc on bc.codigo = conv.banco; "; ?>

<?php $query = $conexao->query($SQL); ?>

<?php $array = $query->fetchAll(PDO::FETCH_ASSOC); ?>

<!DOCTYPE html>
<html lang='pt-BR'>
<html xmlns='http://www.w3.org/1999/xhtml'>

<head>
    <title>Contratos</title>
</head>

<body>
    <h1>Contratos</h1>
    <hr>
    <table class='data display datatable' id='example'>
        <thead>
            <tr>
                <th>Nome</th>
                <th>Verba</th>
                <th>Contrato</th>
                <th>Inclusão</th>
                <th>Valor</th>
                <th>Prazo</th>
            </tr>
        </thead>

        <tbody>

            <?php foreach ($array as $campo) : ?>

                <tr class="odd gradeX">

                    <td class="center"> <?= $campo["nome"]; ?> </td>
                    <td class="center"> R$ <?= number_format($campo["verba"], 2, ',', '.'); ?> </td>
                    <td class="center"> <?= $campo["codigo"]; ?> </td>
                    <?php $dataI = new datetime($campo["data_inclusao"]); ?>
                    <td class="center"> <?= $dataI->format('d/m/Y'); ?> </td>
                    <td class="center"> R$ <?= number_format($campo["valor"], 2, ',', '.'); ?> </td>
                    <?php $data = new datetime($campo["prazo"]); ?>
                    <td class="center"> <?= $data->format('d/m/Y'); ?> </td>
                <?php endforeach; ?>
                <?php unset($stmt);; ?>
                <?php unset($conexao); ?>

        </tbody>
    </table>

</body>

</html>