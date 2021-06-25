# TimeOfDevelopChartsTest

En la Tabla siguiente se muestra los resultados obtenidos del experimento realizado bajo las mismas condiciones como se puede apreciar en los videos; donde se logró que EchartsTag obtuvo el menor tiempo en desarrollo de 14.17 minutos, seguido por HighCharts y JFreeChart. Por otro lado, también se hizo el control del tiempo sobre demora o latencia en la visualización de la gráfica, donde destaca Chart.js y HighCharts, seguido de EchartsTag y FusionCharts, para ello mencionar que las pruebas se hicieron con la misma máquina que tiene la capacidad de 32 GB de memoria RAM y CPU de 3.6GHz Intel Xeon.

| Frameworks / Librerías | Tipo Grafico | Tiempo en desarrollo (min) | Promedio (min) | Evidencia | Promedio de Tiempo en Ejecución (ms) | Promedio (ms) |
| :---         |     :---:      |       :---:  | :---:    |  :---: | :---:    |---: |
| EchartsTag   | PieChart/BarChart     | 10 / 18.34   | 14.17 | https://youtu.be/XCODV0CAG2 | 3 / 4  | 3.5 |
| FusionCharts     | PieChart/BarChart      | 11 / 34.55    | 22.775 | https://youtu.be/xwXoWtrfXzA | 3 / 4  | 3.5 |
| JFreeChart     | PieChart/BarChart      | 14 / 15    | 14.5 | https://youtu.be/geuuwngQFlQ | 20 / 30  | 25 |
| Chart.js     | PieChart/BarChart      | 26.58 / 40    | 33.29 | https://youtu.be/UUhAjEUGICE | 2 / 3.5  | 2.75 |
| HighCharts     | PieChart/BarChart      | 9 / 19.44    | 14.22 | https://youtu.be/5C9bpEX4YBI | 2.5 / 3.5  | 3 |


En la siguiente tabla se aprecia los resultados donde EchartsTag obtiene un mayor puntaje, por lo que sería una buena propuesta en optar por esta alternativa, ya que FusionCharts e HighCharts son las que más se asemejan en cuanto a interactividad; sin embargo, implican costos para el uso comercial además de requerir conocimientos en JavaScript. Por otro lado, podría ser Charts.js sin embargo implica mayor tiempo en desarrollo y no ofrece una información más clara como las otras alternativas, y no se podría optar por JFreeChart ya que no son interactivas.

| Frameworks / Librerías |No requiere Conocimiento en JavaScript | Gráfico Interactivo | Soporte Canvas | Soporte de Gráficos 3D (3 dimensiones) | Código Open Source | No requiere pago (uso comercial) | Puntaje |
| :---         |     :---:      |       :---:  | :---:    |  :---: | :---:    | :---: |---: |
| EchartsTag   | 1    |1   | 1 | 1 | 1  | 1 | 6 |
| FusionCharts   | 0.5|1   | 1 | 0 | 0  | 0.5 | 3 |
| JFreeChart   | 1    |0   | 0 | 0 | 1  | 1 | 3 |
| Chart.js   | 0    |1   | 1 | 0 | 1  | 1 | 4 |
| HighCharts   | 0    |1   | 0 | 1 | 0  | 0 | 2 |
