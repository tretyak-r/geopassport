<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>GeoPassport</title>
        
        <script src="<c:url value="/js/jquery-1.11.3.min.js" />" > </script>
        
        <link rel="stylesheet" href="<c:url value="/css/lib/bootstrap.min.css" />" type="text/css">
        <script src="<c:url value="/js/bootstrap.min.js" />" > </script>
        
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/lib/ol.css" />">
        <script src="<c:url value="/js/ol.js" />" > </script>
        
        <link rel="stylesheet" href="<c:url value="/css/style_elem.css" />" type="text/css">
        <link rel="stylesheet" href="<c:url value="/css/map.css" />" type="text/css">
        <link rel="stylesheet" href="<c:url value="/css/modal_windows.css" />" type="text/css">
        
    </head>
    <body>
        <div class="container-fluid">
            
            <div id="header">
                <font color="wheat" face="Century Gothic" size="5"> <b>ТЕРИС ГеоПаспорт</b> </font>
            </div>
            
            <div class="row-fluid">
              <div class="span12">
                <div id="map" class="map"></div>
              </div>
            </div>
            
            <div class="span6" id="mouse-position">&nbsp;</div>
              
                
            <div id="changeOrMoving2" class="changeOrMoving2">
                <div>
                    <input type="radio" name="option4" id="change" checked />
                    <label for="change"><img src="<c:url value="/images/change.png" />" width="24" height="24" ></label>
                </div>
                <div>
                    <input type="radio" name="option4" id="moving" />
                    <label for="moving"><img src="<c:url value="/images/moving.png" />" width="24" height="24" ></label>
                </div>
            </div>    
                
            <div id="geometryPaint2" class="geometryPaint2">
                <div>
                    <input type="radio" name="option3" id="pointPaint" checked />
                    <label for="pointPaint"><img src="<c:url value="/images/pointPaint.png" />" width="24" height="24" ></label>
                </div>
                <div>
                    <input type="radio" name="option3" id="linePaint" />
                    <label for="linePaint"><img src="<c:url value="/images/linePaint.png" />" width="24" height="24" ></label>
                </div>
                <div>
                    <input type="radio" name="option3" id="polygonPaint" />
                    <label for="polygonPaint"><img src="<c:url value="/images/polygonPaint.png" />" width="24" height="24" ></label>
                </div>
                <div>
                    <input type="radio" name="option3" id="circlePaint" />
                    <label for="circlePaint"><img src="<c:url value="/images/circlePaint.png" />" width="24" height="24" ></label>
                </div>
                <div>
                    <input type="radio" name="option3" id="squarePaint" />
                    <label for="squarePaint"><img src="<c:url value="/images/square.png" />" width="24" height="24" ></label>
                </div>
                <div>
                    <input type="radio" name="option3" id="boxPaint" />
                    <label for="boxPaint"><img src="<c:url value="/images/boxPaint.png" />" width="24" height="24" ></label>
                </div>
            </div>

                
            <button id="paint"><img src="<c:url value="/images/paint.png" />" width="26" height="26" ></button>
            <button id="edit"><img src="<c:url value="/images/edit.png" />" width="26" height="26" ></button>
            
            
            <button id="cancelEdit2"><img src="<c:url value="/images/cancel.png" />" width="26" height="26" ></button>

            <button id="cancelPaint2"><img src="<c:url value="/images/cancel.png" />" width="26" height="26" ></button>
            <button id="deletePaint2"><img src="<c:url value="/images/clear.png" />" width="26" height="26" ></button>
            
            
            <button id="log_in"><font size="2"> <b>Войти</b> </font></button>
            <font size="3"><select id="selects_modes" name="selects_modes">
                <option>Режим анализа</option>
                <option>Режим редактирования</option>
                <option>Режим объекта</option>
                <option>Режим администрирования</option>
            </select></font>
            
            
            <div id="modal_form"><!-- Сaмo oкнo --> 
                    <span id="modal_close">X</span> <!-- Кнoпкa зaкрыть --> 
                    <form>
                        <label>Введите имя пользователя</label>
                        <input type="text" name="" value="" />
                        <label>Введите пароль</label>
                        <input type="password" name="" value="" />
                        <input type="submit" value="Войти в систему" />
                    </form>
            </div>
            <div id="overlay"></div><!-- Пoдлoжкa -->
        </div>
            
        <script>
            
            //-------Добавление контролов
            
            //Зум в виде слайда, добавление ползунка
            var zoomslider = new ol.control.ZoomSlider();
            
            // Координаты по позиции мыши
            var mousePositionControl = new ol.control.MousePosition({
                coordinateFormat: ol.coordinate.createStringXY(4),
                projection: 'EPSG:4326',
                className: 'custom-mouse-position',
                target: document.getElementById('mouse-position'),
                undefinedHTML: '&nbsp;'
            });
            
            // Добавление источников */
            var sourcePaint = new ol.source.Vector({wrapX: false});
            
            /*
            var sourceWMS = new ol.source.TileWMS({
                            url: 'http://172.20.12.15:8080/geoserver/PostGIS/wms',
                            params: {LAYERS: 'PostGIS:World_Map', VERSION: '1.1.1'}
                        });*/
            /*
            // Добавление слоя WMS
            var vectorWMS = new ol.layer.Tile({                    
                                source: sourceWMS
                            });
            */
           
            //Добавление слоя OSM
            var OSM = new ol.layer.Tile({source: new ol.source.OSM()});
          
            //Добавление слоя для рисования
            var vectorPaint = new ol.layer.Vector({
                source: sourcePaint,
                style: new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 255, 0.2)'
                    }),
                    stroke: new ol.style.Stroke({
                        color: '#ffcc33',
                        width: 2
                    }),
                    image: new ol.style.Circle({
                        radius: 7,
                        fill: new ol.style.Fill({
                            color: '#ffcc33'
                        })
                    })
                })
            });


            //---------Дополнительные настройки карты
            
            //Фокус карты
            var center = ol.proj.fromLonLat([41.9702, 45.0448]);
            
            //---------Создание карты
            var map = new ol.Map({
                logo: false,
                controls: ol.control.defaults({
                attributionOptions: ({
                    collapsible: false
                    })
                }).extend([mousePositionControl,zoomslider]),
                layers: [OSM, vectorPaint],
                target: 'map',
                view: new ol.View({
                    center: center,
                    zoom: 12
                })
            });
//------------------------------------------------------------------------------            
     
            //Кнопка рисования и редактирования
            var buttonsPaint = document.getElementById('paint');

            //Радиокнопка выбора рисования и редактирования
            var buttonsEdit = document.getElementById('edit');
            
            //Радиокнопка выбора геометрии рисования
            var typeSelectPaint = document.getElementById('geometryPaint2');
            
            //Кнопка закончить рисование
            var buttonsCancelPaint = document.getElementById('cancelPaint2');
            
            //Радиокнопка выбора редактирования и перемещения
            var typeSelectChangeOrMoving = document.getElementById('changeOrMoving2');

            //Кнопка очистить измерения
            var buttonsDeleteAllPaint = document.getElementById('deletePaint2');
            
            //Кнопка закрыть измерения
            var buttonsCancelEdit = document.getElementById('cancelEdit2'); 

            var select = new ol.interaction.Select({
                condition: ol.events.condition.click
            });

//------------------------------------------------------------------------------
            //Обработчик кнопки рисования
            buttonsPaint.onclick = function(e) {
                map.getOverlays().clear();
                Modify.setActive(false);
                map.removeInteraction(select);
                map.removeInteraction(moving);
                
                typeSelectChangeOrMoving.style.display = "none";
                buttonsDeleteAllPaint.style.display = "none";
                buttonsCancelEdit.style.display = "none";
                
                typeSelectPaint.style.display = "block";
                buttonsCancelPaint.style.display = "block";
                

                addInteractionPaint();
            };


            //Обработчик радиокнопки выбора рисования или редактирования
            buttonsEdit.onclick = function(e) {
                
                map.removeInteraction(drawPaint);
                
                typeSelectPaint.style.display = "none";
                buttonsCancelPaint.style.display = "none";
                
                typeSelectChangeOrMoving.style.display = "block";
                buttonsDeleteAllPaint.style.display = "block";
                buttonsCancelEdit.style.display = "block";
                
                if(document.getElementById('change').checked){
                    Modify.setActive(true);
                }
                if(document.getElementById('moving').checked){
                    map.addInteraction(moving);
                    changeInteraction();
                }
            };

            //Обработчик радиокнопки выбора геометрии рисования
            typeSelectPaint.onchange = function(e) {
                map.removeInteraction(drawPaint);
                addInteractionPaint();
            };

            //Обработчик кнопки закрыть рисование 
            buttonsCancelPaint.onclick = function(e) {

                typeSelectPaint.style.display = "none";
                buttonsCancelPaint.style.display = "none";
                
                map.removeInteraction(drawPaint);
            };

            //Обработчик радиокнопки выбора изменения или перемещения
            typeSelectChangeOrMoving.onchange = function(e) {
                
                if(document.getElementById('change').checked){
                    map.removeInteraction(moving);
                    map.removeInteraction(select);
                    Modify.setActive(true);
                }
                
                if(document.getElementById('moving').checked){
                    Modify.setActive(false);
                    changeInteraction();
                    map.addInteraction(moving);

                }
                
            };

            //Обработчик кнопки очистить
            buttonsDeleteAllPaint.onclick = function(e) {
                
                select.getFeatures();

                
                sourcePaint.removeFeature();
                
            };

            //Обработчик кнопки закрыть редактирование 
            buttonsCancelEdit.onclick = function(e) {
                
                typeSelectChangeOrMoving.style.display = "none";
                
                buttonsDeleteAllPaint.style.display = "none"; 
                buttonsCancelEdit.style.display = "none";
                
                map.removeInteraction(moving);
                map.removeInteraction(select);
                Modify.setActive(false);
            };
            
    
//----------Функциональный блок перемещения объектов----------------------------
                window.app = {};
                var app = window.app;
                
                app.Drag = function() {
                    ol.interaction.Pointer.call(this, {
                      handleDownEvent: app.Drag.prototype.handleDownEvent,
                      handleDragEvent: app.Drag.prototype.handleDragEvent,
                      handleMoveEvent: app.Drag.prototype.handleMoveEvent
                      //handleUpEvent: app.Drag.prototype.handleUpEvent
                    });
                    this.coordinate_ = null;
                    this.cursor_ = 'pointer';
                    this.feature_ = null;
                    this.previousCursor_ = undefined;

                };
               
                ol.inherits(app.Drag, ol.interaction.Pointer);
                
                app.Drag.prototype.handleDownEvent = function(evt) {
                    var map = evt.map;

                    var feature = map.forEachFeatureAtPixel(evt.pixel,
                        function(feature, layer) {
                          return feature;
                        });

                    if (feature) {
                      this.coordinate_ = evt.coordinate;
                      this.feature_ = feature;
                    }

                    return !!feature;
                };
                
                app.Drag.prototype.handleDragEvent = function(evt) {
                    var map = evt.map;
/*
                    var feature = map.forEachFeatureAtPixel(evt.pixel,
                        function(feature, layer) {
                          return feature;
                        });
*/
                    var deltaX = evt.coordinate[0] - this.coordinate_[0];
                    var deltaY = evt.coordinate[1] - this.coordinate_[1];

                    var geometry = /** @type {ol.geom.SimpleGeometry} */
                        (this.feature_.getGeometry());
                    geometry.translate(deltaX, deltaY);

                    this.coordinate_[0] = evt.coordinate[0];
                    this.coordinate_[1] = evt.coordinate[1];
                };
                
                app.Drag.prototype.handleMoveEvent = function(evt) {
                    if (this.cursor_) {
                      var map = evt.map;
                      var feature = map.forEachFeatureAtPixel(evt.pixel,
                          function(feature, layer) {
                            return feature;
                          });
                      var element = evt.map.getTargetElement();
                      
                    if (feature) {
                        if (element.style.cursor !== this.cursor_) {
                          this.previousCursor_ = element.style.cursor;
                          element.style.cursor = this.cursor_;
                        }
                      } else if (this.previousCursor_ !== undefined) {
                        element.style.cursor = this.previousCursor_;
                        this.previousCursor_ = undefined;
                      }
                    }
                };
                
                app.Drag.prototype.handleUpEvent = function(evt) {
                    this.coordinate_ = null;
                    this.feature_ = null;
                    return false;
                };   
                
                var moving = new app.Drag();
//------------------------------------------------------------------------------ 
//           
//----------Функциональный блок рисования на карте    
            var drawPaint;
            function addInteractionPaint() {
                
                var value;
                
                if(document.getElementById('pointPaint').checked){
                    value = 'Point';
                }
                
                if(document.getElementById('linePaint').checked){
                    value = 'LineString';
                }
                
                if(document.getElementById('polygonPaint').checked){
                    value = 'Polygon';
                }
                
                if(document.getElementById('circlePaint').checked){
                    value = 'Circle';
                }
                
                if(document.getElementById('squarePaint').checked){
                    value = 'Square';
                }
                
                if(document.getElementById('boxPaint').checked){
                    value = 'Box';
                }
                var geometryFunction, maxPoints;
                if (value === 'Square') {
                  value = 'Circle';
                  geometryFunction = ol.interaction.Draw.createRegularPolygon(4);
                } else if (value === 'Box') {
                  value = 'LineString';
                  maxPoints = 2;
                  geometryFunction = function(coordinates, geometry) {
                    if (!geometry) {
                      geometry = new ol.geom.Polygon(null);
                    }
                    var start = coordinates[0];
                    var end = coordinates[1];
                    geometry.setCoordinates([
                      [start, [start[0], end[1]], end, [end[0], start[1]], start]
                    ]);
                    return geometry;
                  };
                }
                drawPaint = new ol.interaction.Draw({
                  source: sourcePaint,
                  type: /** @type {ol.geom.GeometryType} */ (value),
                  geometryFunction: geometryFunction,
                  maxPoints: maxPoints
                });
                map.addInteraction(drawPaint);

            };
//----------Функциональный блок редактирования на карте              
            var Modify = {
              init: function() {
                this.select = new ol.interaction.Select();
                map.addInteraction(this.select);

                this.modify = new ol.interaction.Modify({
                  features: this.select.getFeatures()
                });
                map.addInteraction(this.modify);

                this.setEvents();
              },
              setEvents: function() {
                var selectedFeatures = this.select.getFeatures();

                this.select.on('change:active', function() {
                  selectedFeatures.forEach(selectedFeatures.remove, selectedFeatures);
                });
              },
              setActive: function(active) {
                this.select.setActive(active);
                this.modify.setActive(active);
              }
            };
            Modify.init();      
            Modify.setActive(false);
      
//------------------------------------------------------------------------------ 
//----------Функциональный блок выделение объектов на карте              
            var changeInteraction = function() {
                if (select !== null) {
                    map.addInteraction(select);
                    select.on('select', function(e) {
                      $('#status').html('&nbsp;' + e.target.getFeatures().getLength() +
                          ' selected features (last operation selected ' + e.selected.length +
                          ' and deselected ' + e.deselected.length + ' features)');
                    });
                }
            };    
      
//------------------------------------------------------------------------------ 



//          //Выделение объекта     

            var snap = new ol.interaction.Snap({
              source: vectorPaint.getSource()
            });
            map.addInteraction(snap);

//----------Конец функционального блока рисования--------------------------------------------------------------------             
 
        </script>
    </body>
</html>
