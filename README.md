# Pie-Chart-Timer
A unity script and CG shader that can be used to create a 2D UI sprite pie chart that counts down over time.

# Basics

With a circle sprite with the PieChart shader and a PieChartTimer component attached, as long as the PieChartTimer script is enabled, the pie chart will fill in over time.

In the Unity Editor you can set how long it takes for the pie chart to time down.


# Pie Chart Shader

You can use the pie chart shader for non-timers, but you will have to set the shaders "_Fraction" value to a float number between 0 and 1.

This represents how complete the pie chart is.

