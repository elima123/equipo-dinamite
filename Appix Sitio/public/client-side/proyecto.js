const generalView = document.querySelector(".general-view")
const riesgosView = document.querySelector(".riesgos-view")
const analisisView = document.querySelector(".analisis-view")
const navtab1 = document.querySelector("#navtab-1")
const navtab2 = document.querySelector("#navtab-2")
const navtab3 = document.querySelector("#navtab-3")

function viewInfo() {
    riesgosView.classList.add('hidden')
    analisisView.classList.add('hidden')
    navtab2.classList.remove('active')
    navtab3.classList.remove('active')

    generalView.classList.remove('hidden')
    navtab1.classList.add('active')
}

function viewRiesgos() {
    generalView.classList.add('hidden')
    analisisView.classList.add('hidden')
    navtab1.classList.remove('active')
    navtab3.classList.remove('active')

    riesgosView.classList.remove('hidden')
    navtab2.classList.add('active')
}

function viewAnalisis() {
    generalView.classList.add('hidden')
    riesgosView.classList.add('hidden')
    navtab1.classList.remove('active')
    navtab2.classList.remove('active')

    analisisView.classList.remove('hidden')
    navtab3.classList.add('active')
} 
(function (H) {
    H.seriesTypes.pie.prototype.animate = function (init) {
            const series = this,
            chart = series.chart,
            points = series.points,
            {
                    animation
            } = series.options,
            {
                    startAngleRad
            } = series;

            function fanAnimate(point, startAngleRad) {
            const graphic = point.graphic,
                    args = point.shapeArgs;

            if (graphic && args) {

                    graphic
                    // Set inital animation values
                    .attr({
                            start: startAngleRad,
                            end: startAngleRad,
                            opacity: 1
                    })
                    // Animate to the final position
                    .animate({
                            start: args.start,
                            end: args.end
                    }, {
                            duration: animation.duration / points.length
                    }, function () {
                            // On complete, start animating the next point
                            if (points[point.index + 1]) {
                            fanAnimate(points[point.index + 1], args.end);
                            }
                            // On the last point, fade in the data labels, then
                            // apply the inner size
                            if (point.index === series.points.length - 1) {
                            series.dataLabelsGroup.animate({
                                    opacity: 1
                            },
                            void 0,
                            function () {
                                    points.forEach(point => {
                                    point.opacity = 1;
                                    });
                                    series.update({
                                    enableMouseTracking: true
                                    }, false);
                                    chart.update({
                                    plotOptions: {
                                            pie: {
                                            innerSize: '40%',
                                            borderRadius: 8
                                            }
                                    }
                                    });
                            });
                            }
                    });
            }
            }

            if (init) {
            // Hide points on init
            points.forEach(point => {
                    point.opacity = 0;
            });
            } else {
            fanAnimate(points[0], startAngleRad);
            }
    };
    }(Highcharts));

    document.addEventListener('DOMContentLoaded', function () {
        Highcharts.chart('container', {
            chart: {
                type: 'pie'
            },
            title: {
                text: 'Departmental Strength of the Company',
                align: 'left'
            },
            subtitle: {
                text: 'Custom animation of pie series',
                align: 'left'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            accessibility: {
                point: {
                    valueSuffix: '%'
                }
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    borderWidth: 2,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b><br>{point.percentage}%',
                        distance: 20
                    }
                }
            },
            series: [{
                enableMouseTracking: false,
                animation: {
                    duration: 2000
                },
                colorByPoint: true,
                data: [{
                    name: 'Customer Support',
                    y: 21.3
                }, {
                    name: 'Development',
                    y: 18.7
                }, {
                    name: 'Sales',
                    y: 20.2
                }, {
                    name: 'Marketing',
                    y: 14.2
                }, {
                    name: 'Other',
                    y: 25.6
                }]
            }]
        });
    });