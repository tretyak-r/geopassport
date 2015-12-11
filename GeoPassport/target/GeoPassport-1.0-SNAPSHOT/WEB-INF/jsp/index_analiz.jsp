<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>GeoPassport</title>
        
        <script src="<c:url value="/js/jquery-1.11.3.min.js" />" > </script>
        
        <link rel="stylesheet" href="<c:url value="/css/bootstrap.min.css" />" type="text/css">
        <script src="<c:url value="/js/bootstrap.min.js" />" > </script>
        
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/ol.css" />">
        <script src="<c:url value="/js/ol.js" />" > </script>
        <link rel="stylesheet" href="<c:url value="/css/style.css" />" type="text/css">
        
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
            
            <div id="geometryMeasure" class="geometryMeasure">
                <div>
                    <input type="radio" name="option1" id="lineMeasure" checked />
                    <label for="lineMeasure"><img src="<c:url value="/images/lineMeasure.png" />" width="24" height="24" ></label>
                </div>
                <div>
                    <input type="radio" name="option1" id="polygonMeasure" />
                    <label for="polygonMeasure"><img src="<c:url value="/images/area.png" />" width="24" height="24" ></label>
                </div>
            </div>
                
            <div id="paintOrEdit" class="paintOrEdit">
                <div>
                    <input type="radio" name="option2" id="paint" checked />
                    <label for="paint"><img src="<c:url value="/images/paint.png" />" width="24" height="24" ></label>
                </div>
                <div>
                    <input type="radio" name="option2" id="edit" />
                    <label for="edit"><img src="<c:url value="/images/edit.png" />" width="24" height="24" ></label>
                </div>
            </div>
                
            <div id="changeOrMoving" class="changeOrMoving">
                <div>
                    <input type="radio" name="option4" id="change" checked />
                    <label for="change"><img src="<c:url value="/images/change.png" />" width="24" height="24" ></label>
                </div>
                <div>
                    <input type="radio" name="option4" id="moving" />
                    <label for="moving"><img src="<c:url value="/images/moving.png" />" width="24" height="24" ></label>
                </div>
            </div>    
                
            <div id="geometryPaint" class="geometryPaint">
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
                
            <button id="measure"><img src="<c:url value="/images/measure.png" />" width="26" height="26" ></button>
            <button id="cancelMeasure"><img src="<c:url value="/images/cancel.png" />" width="26" height="26" ></button>
            <button id="clearMeasure"><img src="<c:url value="/images/clear.png" />" width="26" height="26" ></button>
            
            <button id="cancelEdit"><img src="<c:url value="/images/cancel.png" />" width="26" height="26" ></button>

            <button id="paintAndEdit"><img src="<c:url value="/images/PaintAndEdit.png" />" width="26" height="26" ></button>
            <button id="cancelPaint"><img src="<c:url value="/images/cancel.png" />" width="26" height="26" ></button>
            <button id="deletePaint"><img src="<c:url value="/images/clear.png" />" width="26" height="26" ></button>
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
            var sourceMeasure = new ol.source.Vector();
            var sourcePaint = new ol.source.Vector({wrapX: false});
            
            var sourceWMS = new ol.source.TileWMS({
                            url: 'http://172.20.12.15:8080/geoserver/PostGIS/wms',
                            params: {LAYERS: 'PostGIS:World_Map', VERSION: '1.1.1'}
                        });
            // Добавление слоя WMS
            var vectorWMS = new ol.layer.Tile({                    
                                source: sourceWMS
                            });
            
            //Добавление слоя OSM
            var OSM = new ol.layer.Tile({source: new ol.source.OSM()});
       
            //Добавление слоя для измерения
            var vectorMeasure = new ol.layer.Vector({
                source: sourceMeasure,
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

            //Присваивание переменной, которая будет учитывать кривизну земли при расчете
            var wgs84Sphere = new ol.Sphere(6378137);
            
            //---------Создание карты
            var map = new ol.Map({
                logo: false,
                controls: ol.control.defaults({
                attributionOptions: ({
                    collapsible: false
                    })
                }).extend([mousePositionControl,zoomslider]),
                layers: [OSM, vectorMeasure, vectorPaint],
                target: 'map',
                view: new ol.View({
                    center: center,
                    zoom: 12
                })
            });
    
//------------------------------------------------------------------------------
            //Кнопка измерения
            var buttonsMeasure = document.getElementById('measure');
            
            //Радиокнопка выбора геометрии измерения                      
            var typeSelectMeasure = document.getElementById('geometryMeasure');
            
            //Кнопка очистить измерения
            var buttonsClearMeasure = document.getElementById('clearMeasure');
            
            //Кнопка закрыть измерения
            var buttonsCancelMeasure = document.getElementById('cancelMeasure');
//------------------------------------------------------------------------------            
     
            //Кнопка рисования и редактирования
            var buttonsPaintAndEdit = document.getElementById('paintAndEdit');

            //Радиокнопка выбора рисования и редактирования
            var typeSelectPaintOrEdit = document.getElementById('paintOrEdit');
            
            //Радиокнопка выбора геометрии рисования
            var typeSelectPaint = document.getElementById('geometryPaint');
            
            //Кнопка закончить рисование
            var buttonsCancelPaint = document.getElementById('cancelPaint');
            
            //Радиокнопка выбора редактирования и перемещения
            var typeSelectChangeOrMoving = document.getElementById('changeOrMoving');

            //Кнопка очистить измерения
            var buttonsDeleteAllPaint = document.getElementById('deletePaint');
            
            //Кнопка закрыть измерения
            var buttonsCancelEdit = document.getElementById('cancelEdit'); 
           
           
            //Обработчик кнопки измерения
            buttonsMeasure.onclick = function(e) {
                //скрытие элементов
                typeSelectPaintOrEdit.style.display = "none";
                typeSelectPaint.style.display = "none";
                typeSelectChangeOrMoving.style.display = "none";
                buttonsDeleteAllPaint.style.display = "none"; 
                buttonsCancelPaint.style.display = "none";
                buttonsCancelEdit.style.display = "none";
                
                map.removeInteraction(drawPaint);
                Modify.setActive(false);
                map.removeInteraction(moving);
                
                typeSelectMeasure.style.display = "block";
                buttonsClearMeasure.style.display = "block"; 
                buttonsCancelMeasure.style.display = "block"; 

                //Определение координат действия курсора мыши
                map.on('pointermove', pointerMoveHandler);
                $(map.getViewport()).on('mouseout', function() {
                    $(helpTooltipElement).addClass('hidden');
                }); 
                addInteractionMeasure();
            };

            //Обработчик радиокнопки выбора геометрии измерения
            typeSelectMeasure.onchange = function(e) {
                map.removeInteraction(drawMeasure);
                addInteractionMeasure();
            };
            
            //Обработчик кнопки очистить измерения
            buttonsClearMeasure.onclick = function(e) {
                sourceMeasure.clear();
                map.getOverlays().clear();
                map.removeInteraction(drawMeasure);
                addInteractionMeasure();
            };
            

            //Обработчик кнопки закрыть 
            buttonsCancelMeasure.onclick = function(e) {
                typeSelectMeasure.style.display = "none";
                buttonsClearMeasure.style.display = "none"; 
                buttonsCancelMeasure.style.display = "none";
                
                map.removeInteraction(drawMeasure);
                
                map.un('pointermove', pointerMoveHandler);
                sourceMeasure.clear();
                map.getOverlays().clear();
            };
            
//------------------------------------------------------------------------------
            //Обработчик кнопки рисования
            buttonsPaintAndEdit.onclick = function(e) {
                typeSelectMeasure.style.display = "none";
                buttonsClearMeasure.style.display = "none"; 
                buttonsCancelMeasure.style.display = "none";

                map.removeInteraction(drawMeasure);
                
                map.un('pointermove', pointerMoveHandler);
                sourceMeasure.clear();
                map.getOverlays().clear();
                
                typeSelectPaintOrEdit.style.display = "block";
                
                map.removeInteraction(drawPaint);
                
                if(document.getElementById('paint').checked){
                    
                    typeSelectPaint.style.display = "block";
                    buttonsCancelPaint.style.display = "block";

                    addInteractionPaint();

                }
                if(document.getElementById('edit').checked){
                    
                    typeSelectChangeOrMoving.style.display = "block";
                    buttonsDeleteAllPaint.style.display = "block";
                    buttonsCancelEdit.style.display = "block";
                    
                    
                    if(document.getElementById('change').checked){
                        Modify.setActive(true);
                    }
                    if(document.getElementById('moving').checked){
                        map.addInteraction(moving);
                    }
                }
            };


            //Обработчик радиокнопки выбора рисования или редактирования
            typeSelectPaintOrEdit.onchange = function(e) {
                
                if(document.getElementById('paint').checked){
                    
                    typeSelectChangeOrMoving.style.display = "none";
                    buttonsDeleteAllPaint.style.display = "none";
                    buttonsCancelEdit.style.display = "none";
                    
                    Modify.setActive(false);
                    map.removeInteraction(moving);
                    
                    typeSelectPaint.style.display = "block";
                    buttonsCancelPaint.style.display = "block";

                    addInteractionPaint();
                }
                
                if(document.getElementById('edit').checked){
                    
                    typeSelectPaint.style.display = "none";
                    buttonsCancelPaint.style.display = "none";
                    
                    map.removeInteraction(drawPaint);
                    
                    typeSelectChangeOrMoving.style.display = "block";
                    buttonsDeleteAllPaint.style.display = "block";
                    buttonsCancelEdit.style.display = "block"; 
                    
                    
                    if(document.getElementById('change').checked){
                        Modify.setActive(true);
                    }
                    if(document.getElementById('moving').checked){
                        map.addInteraction(moving);
                    }
                }
                
            };

            //Обработчик радиокнопки выбора геометрии рисования
            typeSelectPaint.onchange = function(e) {
                map.removeInteraction(drawPaint);
                addInteractionPaint();
            };

            //Обработчик кнопки закрыть рисование 
            buttonsCancelPaint.onclick = function(e) {
                
                typeSelectPaintOrEdit.style.display = "none";
                typeSelectPaint.style.display = "none";
                buttonsCancelPaint.style.display = "none";
                
                map.removeInteraction(drawPaint);
            };

            //Обработчик радиокнопки выбора рисования или редактирования
            typeSelectChangeOrMoving.onchange = function(e) {
                
                if(document.getElementById('change').checked){
                    map.removeInteraction(moving);
                    Modify.setActive(true);
                }
                
                if(document.getElementById('moving').checked){
                    Modify.setActive(false);
                    map.addInteraction(moving);

                }
                
            };

            //Обработчик кнопки очистить
            buttonsDeleteAllPaint.onclick = function(e) {
                sourcePaint.clear();
            };

            //Обработчик кнопки закрыть редактирование 
            buttonsCancelEdit.onclick = function(e) {
                
                typeSelectPaintOrEdit.style.display = "none";
                typeSelectChangeOrMoving.style.display = "none";
                
                buttonsDeleteAllPaint.style.display = "none"; 
                buttonsCancelEdit.style.display = "none";
                
                map.removeInteraction(moving);
                Modify.setActive(false);
            };
            
    
//----------Функциональный блок перемещения объектов----------------------------
                window.app = {};
                var app = window.app;
                
                app.Drag = function() {
                    ol.interaction.Pointer.call(this, {
                      handleDownEvent: app.Drag.prototype.handleDownEvent,
                      handleDragEvent: app.Drag.prototype.handleDragEvent,
                      handleMoveEvent: app.Drag.prototype.handleMoveEvent,
                      handleUpEvent: app.Drag.prototype.handleUpEvent
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

                    var feature = map.forEachFeatureAtPixel(evt.pixel,
                        function(feature, layer) {
                          return feature;
                        });

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
//          //Выделение объекта     

            var snap = new ol.interaction.Snap({
              source: vectorPaint.getSource()
            });
            map.addInteraction(snap);

//----------Конец функционального блока рисования--------------------------------------------------------------------             
            
//----------Функциональный блок определения длины и площади геометрии-----------

            //Объявление переменных---------------------------------------------

            //Переменная для создания эскиза для слоя измерений
            var sketch;
            
            //Переменные для создания и заполнения тултипов подсказок
            var helpTooltipElement;
            var helpTooltip;
            
            //Переменные для создания и заполнения тултипов измерения    
            var measureTooltipElement;
            var measureTooltip;
            
            //Статические переменные, используемые в туотипах подсказок 
            var continuePolygonMsg = 'Нарисуйте полигон для измерения площади';
            var continueLineMsg = 'Нарисуйте линию для измерения длины';

            //Переменная для рисования
            var drawMeasure;

     
//------------------------------------------------------------------------------ 
            //Заполнение переменной тултипов подсказок
            var pointerMoveHandler = function (evt) {
                if (evt.dragging) {
                    return;
                }
                var helpMsg = 'Для начала рисования укажите точку';

                if (sketch) {
                    var geom = (sketch.getGeometry());
                    if (geom instanceof ol.geom.Polygon) {
                        helpMsg = continuePolygonMsg;
                    } else if (geom instanceof ol.geom.LineString) {
                        helpMsg = continueLineMsg;
                    }
                }

                helpTooltipElement.innerHTML = helpMsg;
                helpTooltip.setPosition(evt.coordinate);
                $(helpTooltipElement).removeClass('hidden');
            };
//------------------------------------------------------------------------------ 
            
            //Рисование линии или полигона при измерении
            function addInteractionMeasure() {
                
                var type;
                
                if(document.getElementById('lineMeasure').checked){
                    type = 'LineString';
                }
                
                if(document.getElementById('polygonMeasure').checked){
                    type = 'Polygon';
                }
        
                drawMeasure = new ol.interaction.Draw({
                    source: sourceMeasure,
                    type: /** @type {ol.geom.GeometryType} */ (type),
                    style: new ol.style.Style({
                        fill: new ol.style.Fill({
                            color: 'rgba(255, 255, 255, 0.2)'
                        }),
                        stroke: new ol.style.Stroke({
                            color: 'rgba(0, 0, 0, 0.5)',
                            lineDash: [10, 10],
                            width: 2
                        }),
                        image: new ol.style.Circle({
                            radius: 5,
                            stroke: new ol.style.Stroke({
                                color: 'rgba(0, 0, 0, 0.7)'
                            }),
                            fill: new ol.style.Fill({
                                color: 'rgba(255, 255, 255, 0.2)'
                            })
                        })
                    })
                });

                map.addInteraction(drawMeasure);

                createMeasureTooltip();
                createHelpTooltip();

                var listener;
                drawMeasure.on('drawstart',
                    function(evt) {
                        // set sketch
                        sketch = evt.feature;

                        /** @type {ol.Coordinate|undefined} */
                        var tooltipCoord = evt.coordinate;

                        listener = sketch.getGeometry().on('change', function(evt) {
                            var geom = evt.target;
                            var output;
                            if (geom instanceof ol.geom.Polygon) {
                                output = formatArea(/** @type {ol.geom.Polygon} */ (geom));
                                tooltipCoord = geom.getInteriorPoint().getCoordinates();
                            } else if (geom instanceof ol.geom.LineString) {
                                output = formatLength( /** @type {ol.geom.LineString} */ (geom));
                                tooltipCoord = geom.getLastCoordinate();
                            }
                            
                            measureTooltipElement.innerHTML = output;
                            measureTooltip.setPosition(tooltipCoord);
                            
                        });
                    }, this);

                drawMeasure.on('drawend',
                    function(evt) {
                        
                        measureTooltipElement.className = 'tooltip tooltip-static';
                        measureTooltip.setOffset([0, -7]);
                        // unset sketch
                        sketch = null;
                        // unset tooltip so that a new one can be created
                        measureTooltipElement = null;
                        createMeasureTooltip();
                        ol.Observable.unByKey(listener);
                    }, this);
            }
            
//------------------------------------------------------------------------------            
            //Добавление на карту наложений в виде тултипов подсказок
            function createHelpTooltip() {
                if (helpTooltipElement) {
                    helpTooltipElement.parentNode.removeChild(helpTooltipElement);
                }
                helpTooltipElement = document.createElement('div');
                helpTooltipElement.className = 'tooltip hidden';
                helpTooltip = new ol.Overlay({
                    element: helpTooltipElement,
                    offset: [15, 0],
                    positioning: 'center-left'
                });
                map.addOverlay(helpTooltip);
            }
            //Добавление на карту наложений в виде тултипов значения измерений
            function createMeasureTooltip() {
                if (measureTooltipElement) {
                    measureTooltipElement.parentNode.removeChild(measureTooltipElement);
                }
                measureTooltipElement = document.createElement('div');
                measureTooltipElement.className = 'tooltip tooltip-measure';
                measureTooltip = new ol.Overlay({
                    element: measureTooltipElement,
                    offset: [0, -15],
                    positioning: 'bottom-center'
                });
                map.addOverlay(measureTooltip);
            }
            

//------------------------------------------------------------------------------

            /**
             * Измерение длины
             * @param {ol.geom.LineString} line
             * @return {string}
             */
            var formatLength = function(line) {
                var length;

                var coordinates = line.getCoordinates();
                length = 0;
                var sourceProj = map.getView().getProjection();
                for (var i = 0, ii = coordinates.length - 1; i < ii; ++i) {
                    var c1 = ol.proj.transform(coordinates[i], sourceProj, 'EPSG:4326');
                    var c2 = ol.proj.transform(coordinates[i + 1], sourceProj, 'EPSG:4326');
                    length += wgs84Sphere.haversineDistance(c1, c2);
                }

                var output;
                if (length > 100) {
                    output = (Math.round(length / 1000 * 100) / 100) + ' ' + 'km';
                } else {
                    output = (Math.round(length * 100) / 100) + ' ' + 'm';
                }
                return output;
            };

//------------------------------------------------------------------------------
            /**
             * Вычисление площади
             * @param {ol.geom.Polygon} polygon
             * @return {string}
             */
            var formatArea = function(polygon) {
                var area;
                var sourceProj = map.getView().getProjection();
                var geom = (polygon.clone().transform(
                    sourceProj, 'EPSG:4326'));
                var coordinates = geom.getLinearRing(0).getCoordinates();
                area = Math.abs(wgs84Sphere.geodesicArea(coordinates));

                var output;
                if (area > 10000) {
                    output = (Math.round(area / 1000000 * 100) / 100) + ' ' + 'km<sup>2</sup>';
                } else {
                    output = (Math.round(area * 100) / 100) + ' ' + 'm<sup>2</sup>';
                }
                return output;
            };
//-----Конец функционального блока определения длины и площади геометрии--------
            $(document).ready(function() { // вся мaгия пoсле зaгрузки стрaницы
                $('#log_in').click( function(event){ // лoвим клик пo ссылки с id="go"
                    event.preventDefault(); // выключaем стaндaртную рoль элементa
                    $('#overlay').fadeIn(400, // снaчaлa плaвнo пoкaзывaем темную пoдлoжку
                        function(){ // пoсле выпoлнения предъидущей aнимaции
                            $('#modal_form') 
                            .css('display', 'block') // убирaем у мoдaльнoгo oкнa display: none;
                            .animate({opacity: 1, top: '50%'}, 200); // плaвнo прибaвляем прoзрaчнoсть oднoвременнo сo съезжaнием вниз
                        });
                });
                    /* Зaкрытие мoдaльнoгo oкнa, тут делaем тo же сaмoе нo в oбрaтнoм пoрядке */
                $('#modal_close, #overlay').click( function(){ // лoвим клик пo крестику или пoдлoжке
                    $('#modal_form')
                        .animate({opacity: 0, top: '45%'}, 200,  // плaвнo меняем прoзрaчнoсть нa 0 и oднoвременнo двигaем oкнo вверх
                            function(){ // пoсле aнимaции
                                $(this).css('display', 'none'); // делaем ему display: none;
                                $('#overlay').fadeOut(400); // скрывaем пoдлoжку
                            }
                        );
                });
            });
        </script>
    </body>
</html>
