<?php echo $header; ?>
<div id="content">
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/payment.png" alt="" />Todo Pago (<?php echo $version; ?>)</h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
     <?php if ($need_upgrade) { ?>
     <p class="important-message">Usted ha subido una nueva versión del m&oacute;dulo, para su correcto funcionamiento debe actualizarlo haciendo click en el botón "Upgrade"</p>
     <?php } ?>
      <div id="htabs" class="htabs">
        <a href="#tab-general">GENERAL</a>
        <a href="#tab-test">AMBIENTE DEVELOPERS</a>
        <a href="#tab-produccion">AMBIENTE PRODUCCION</a>
        <a href="#tab-estadosdelpedido">ESTADOS DEL PEDIDO</a>
        <a href="#tab-status">Status de las Operacion</a>
      </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
       <input type="hidden" name="upgrade" value="<?php echo $need_upgrade ?>">
       <input type="hidden" name="version" value="<?php echo $version; ?>">
        <!-- TAB GENERAL -->
        <div id="tab-general">
          <table class="form">
            <tr>
              <td>Enabled</td>
              <td><select name="todopago_status">
                <?php if ($todopago_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td><td><em>Activa y desactiva el módulo de pago</em></td>
            </tr>
            <tr>
              <td>Authorization HTTP</td>
              <td><input type="text" name="authorizationHTTP" value="<?php echo $authorizationHTTP; ?>" size="25" /></td>
              <td><em>se deben para datos en formato json. ejemplo: { "Authorization":"PRISMA 912EC803B2CE49E4A541068D495AB570"}</em></td>
            </tr>
            <tr>
              <td>Segmento del Comercio</td>
              <td>
                <select name="segmentodelcomercio">
                  <option value="Retail" <?php if ($segmentodelcomercio=="Retail") echo "selected"?> >Retail</option>
                  <!--<option value="Ticketing" <?php if ($segmentodelcomercio=="Ticketing") echo "selected"?> >Ticketing</option>
                  <option value="Services" <?php if ($segmentodelcomercio=="Services") echo "selected"?> >Service</option>                  
                  <option value="Digital Goods" <?php if ($segmentodelcomercio=="Digital Goods") echo "selected"?> >Digital Goods</option>
                </select>-->
              </td>
              <td><em>La elección del segmento determina los tipos de datos a enviar</em></td>
            </tr>
            <!--<tr> //PRISMA pidió que se saque
              <td>Canal de Ingreso del Pedido</td>
              <td>
                <select name="canaldeingresodelpedido">
                  <option value="Web" <?php if ($canaldeingresodelpedido=="Web") echo "selected" ?>>Web</option>
                  <option value="Mobile" <?php if ($canaldeingresodelpedido=="Mobile") echo "selected" ?>>Mobile</option>
                  <option value="Telefonica" <?php if ($canaldeingresodelpedido=="Telefonica") echo "selected" ?>>Telefonica</option>
                </select>
              </td>
              <td><em></em></td>
            </tr>-->
            <tr>
              <td>Dead Line</td>
              <td><input type="number" name="deadline" value="<?php echo $deadline; ?>"/></td>
              <td><em>días máximos para la entrega</em></td>
            </tr>

            <tr>
              <td>Modo Developers o Producción</td>
              <td>
                <select name="modotestproduccion">
                  <option value="Test" <?php if ($modotestproduccion=="Test") echo "selected" ?>>Developers</option>
                  <option value="Produccion" <?php if ($modotestproduccion=="Produccion") echo "selected" ?>>produccion</option>
                </select>
              </td>
              <td><em>Debe ser cofigurado en CONFIGURACION - AMBIENTE DEVELOPERS / PRODUCCION</em></td>
            </tr>          
          </table> 
        </div>
        <!-- END TAB GENERAL-->

        <!-- TAB AMBIENTE TEST -->
        <div id="tab-test">
          <table class="form">
              <td>Id Site Todo Pago</td>
              <td><input type="text" name="idsitetest" value="<?php echo $idsitetest; ?>" /></td>
              <td><em>Número de Comercio provisto por Todo Pago</em></td>
            </tr>
            <tr>
              <td>Security code</td>
              <td><input type="text" name="securitytest" value="<?php echo $securitytest; ?>" /></td>
              <td><em>Código provisto por Todo Pago</em></td>
            </tr>
          </table>
        </div>
        <!-- END TAB AMBIENTE TEST -->
        
        <!-- TAB AMBIENTE PRODUCCION -->
        <div id="tab-produccion">
          <table class="form">
            <tr>
              <td>Id Site Todo Pago</td>
              <td><input type="text" name="idsiteproduccion" value="<?php echo $idsiteproduccion; ?>" /></td>
              <td><em>Número de Comercio provisto por Todo Pago</em></td>
            </tr>
            <tr>
              <td>Security code</td>
              <td><input type="text" name="securityproduccion" value="<?php echo $securityproduccion; ?>" /></td>
              <td><em>Código provisto por Todo Pago</em></td>
            </tr>
          </table>
        </div>
        <!--END TAB AMBIENTE PRODUCCION -->
        
        <!-- TAB ESTADO DEL PEDIDO -->
        <div id="tab-estadosdelpedido">
          <table class="form">

            <tr>
              <td>Estado cuando la transaccion ha sido iniciada</td>
              <td><select name="todopago_order_status_id_pro">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $todopago_order_status_id_pro) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            </tr>
            <tr>
              <td>Estado cuando la transaccion ha sido aprovada</td>
              <td><select name="todopago_order_status_id_aprov">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $todopago_order_status_id_aprov) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            </tr>
            <tr>
              <td>Estado cuando la transaccion ha sido Rechazada</td>
              <td><select name="todopago_order_status_id_rech">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $todopago_order_status_id_rech) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            </tr>
            <tr>
              <td>Estado cuando la transaccion ha sido Offline</td>
              <td><select name="todopago_order_status_id_off">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $todopago_order_status_id_off) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            </tr>
          </table>

        </div>
        <!-- END TAB ESTADO DEL PEDIDO -->

        <!-- TAB STATUS-->
        <div id="tab-status">
          <table class="form" border="1">

            <?php 
            $this->load->model('payment/todopago');
            $orders_array = $this->model_payment_todopago->get_orders();
            $orders_array = json_encode($orders_array->rows);
            //var_dump($orders_array);
            ?>
            <script type="text/javascript">
              $(document).ready(function() {
                var valore = '<?php echo $orders_array ?>';
                var tabla_db = '';
                valore_json = JSON.parse(valore);
                valore_json.forEach(function (value, key){
                  tabla_db += "<tr>";
                  tabla_db +="<th><a onclick='verstatus("+value.order_id+")'>#"+value.order_id+"</a></th>";
                  tabla_db +="<th>"+value.date_added+"</th>";
                  tabla_db +="<th>"+value.firstname+"</th>";
                  tabla_db +="<th>"+value.lastname+"</th>";
                  tabla_db +="<th>"+value.store_name+"</th>";
                  tabla_db +="<th>$"+value.total+"</th>";
                  tabla_db +="</tr>";
                });



                $("#tabla_db").prepend(tabla_db);

                $('#tabla').dataTable();
                
              } );

              function verstatus (order){
                $('#content').css('cursor', 'progress');
                url_get_status = '<?php echo $this->url->link("payment/todopago/get_status&token=".$this->session->data["token"]); ?>';
                $.get(url_get_status,{order_id:order},llegadaDatos); 
                return false;                                           
              }

              function llegadaDatos(datos)
              {
                $('#content').css('cursor', 'auto');
                alert(datos);
              }  
            </script>
            <link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.css">
            <table id="tabla" class="display" cellspacing="0" width="100%">

              <thead>
                <tr>
                  <th>Nro</th>
                  <th>Fecha</th>
                  <th>Nombre</th>
                  <th>Apellido</th>
                  <th>Tienda</th>
                  <th>Total</th>
                </tr>
              </thead>

              <tfoot>
                <tr>
                  <th>Nro</th>
                  <th>Fecha</th>
                  <th>Nombre</th>
                  <th>Apellido</th>
                  <th>Tienda</th>
                  <th>Total</th>
                </tr>
              </tfoot>

              <tbody id="tabla_db">   
              </tbody>
            </table>
          </div>
          <!-- END TAB STATUS-->

        </form>
      </div>
    </div>

    <script type="text/javascript"><!--
      $('#htabs a').tabs();
      //--></script> 
      <?php echo $footer; ?>
