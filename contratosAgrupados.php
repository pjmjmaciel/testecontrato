<?php //require_once __DIR__ .'/db_pdo.php';
?>

<?php // $conexao = Conexao::getConnection(); 
?>
<?php $conexao =  new PDO("mysql:host=db;port=3306;dbname=testeLogica", "root", "MYSQL_ROOT_PASSWORD"); ?>

<?php $SQL = "SELECT bc.nome
,conv.verba
, 
(
SELECT cntt.data_inclusao
FROM `Tb_contrato` cntt
inner join Tb_convenio_servico cs1 on cs1.codigo = cntt.convenio_servico
inner join Tb_convenio conv1 on conv1.codigo = cs1.convenio
inner join Tb_banco bc1 on bc1.codigo = conv1.banco
where bc1.nome = bc.nome and conv1.verba = conv.verba order by cntt.data_inclusao desc limit 1    
) as 'MaisNovo'
,
(
SELECT cntt.data_inclusao
FROM `Tb_contrato` cntt
inner join Tb_convenio_servico cs1 on cs1.codigo = cntt.convenio_servico
inner join Tb_convenio conv1 on conv1.codigo = cs1.convenio
inner join Tb_banco bc1 on bc1.codigo = conv1.banco
where bc1.nome = bc.nome and conv1.verba = conv.verba order by cntt.data_inclusao asc limit 1    
) as 'MaisAntigo'
,
(
SELECT sum(cntt.valor)
FROM `Tb_contrato` cntt
inner join Tb_convenio_servico cs1 on cs1.codigo = cntt.convenio_servico
inner join Tb_convenio conv1 on conv1.codigo = cs1.convenio
inner join Tb_banco bc1 on bc1.codigo = conv1.banco
where bc1.nome = bc.nome and conv1.verba = conv.verba group by bc1.nome, conv1.verba    
) as 'soma'
FROM `Tb_contrato` contrato 
inner join Tb_convenio_servico cs on cs.codigo = contrato.convenio_servico
inner join Tb_convenio conv on conv.codigo = cs.convenio
inner join Tb_banco bc on bc.codigo = conv.banco
group by bc.nome,conv.verba; "; ?>

<?php $query = $conexao->query($SQL); ?>

<?php $array = $query->fetchAll(PDO::FETCH_ASSOC); ?>

<!DOCTYPE html>
<html lang='pt-BR'>
<html xmlns='http://www.w3.org/1999/xhtml'>

<head>
    <title>Contratos Agrupados</title>
</head>

<body>
    <h1>Contratos</h1>
    <hr>
    <table class='data display datatable' id='example'>
        <thead>
            <tr>
                <th>Nome</th>
                <th>Verba</th>
                <th>Mais recente</th>
                <th>Mais antigo</th>
                <th>Total</th>
            </tr>
        </thead>

        <tbody>

            <?php foreach ($array as $campo) : ?>

                <tr class="odd gradeX">

                    <td class="center"> <?= $campo["nome"]; ?> </td>
                    <td class="center"> <?= $campo["verba"]; ?> </td>
                    <?php $dataI = new datetime($campo["MaisNovo"]); ?>
                    <td class="center"> <?= $dataI->format('d/m/Y'); ?> </td>
                    <?php $dataA = new datetime($campo["MaisAntigo"]); ?>
                    <td class="center"> <?= $dataA->format('d/m/Y'); ?> </td>
                    <td class="center"> R$ <?= number_format($campo["soma"], 2, ',', '.'); ?> </td>
                <?php endforeach; ?>
                <?php unset($stmt);; ?>
                <?php unset($conexao); ?>

        </tbody>
    </table>

</body>

</html>