within WindStandardModels.AdditionalModels.Blocks;

model LimPIDFreeze_mod "PI controller with limited output, anti-windup compensation, setpoint weighting, optional feed-forward and optional freezing of the state"
  
  /*
  * Copyright (c) 2024, RTE (http://www.rte-france.com)
  * 
  * All rights reserved.
  * This Source Code Form is subject to the terms of the Mozilla Public
  * License, v. 2.0. If a copy of the MPL was not distributed with this
  * file, you can obtain one at http://mozilla.org/MPL/2.0/.
  * SPDX-License-Identifier: MPL-2.0
  *
  */
  extends Modelica.Blocks.Interfaces.SVcontrol;
  
  parameter Real K = 1 "Gain of controller";
  parameter Dynawo.Types.Time Ti = 0.5 "Time constant of Integrator Modelica.Block";
  parameter Real Wp = 1 "Set-point weight for Proportional Modelica.Block (0..1)";
  parameter Real Ni = 0.9 "Ni*Ti is time constant of anti-windup compensation";
  parameter Boolean WithFeedForward = false "Use feed-forward input?" annotation(
    Evaluate = true,
    choices(checkBox = true));
  parameter Real Kff = 1 "Gain of feed-forward input" annotation(
    Dialog(enable = WithFeedForward));
  parameter Real Xi0 = 0 "Initial or guess value for integrator output (= integrator state)";
  parameter Real Y0 = 0 "Initial value of output";
  parameter Boolean Strict = false "= true, if Strict limits with noEvent(..)" annotation(
    Evaluate = true,
    choices(checkBox = true),
    Dialog(tab = "Advanced"));
  parameter Real YMax(start = 1) "Upper limit of output";
  parameter Real YMin = -YMax "Lower limit of output";
  
  output Real controlError = u_s - u_m "Control error (set point - measurement)";
  constant Dynawo.Types.Time unitTime = 1 annotation(
    HideResult = true);
  Modelica.Blocks.Interfaces.RealInput uFF if WithFeedForward "Optional connector of feed-forward input signal" annotation(
    Placement(transformation(origin = {60, -120}, extent = {{20, -20}, {-20, 20}}, rotation = 270)));
  Modelica.Blocks.Interfaces.BooleanInput freeze annotation(
    Placement(visible = true, transformation(origin = {-94, -124}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-68, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Math.Add feedback(k1 = 1, k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {16, 0}, extent = {{-80, 40}, {-60, 60}}, rotation = 0)));
  Modelica.Blocks.Math.Add addPID annotation(
    Placement(visible = true, transformation(origin = {34, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addSat(k1 = +1, k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {38, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Math.Gain gainTrack(k = Ni) annotation(
    Placement(visible = true, transformation(origin = {-42, 24}, extent = {{0, -80}, {-20, -60}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant FFzero(k = 0) if not WithFeedForward annotation(
    Placement(visible = true, transformation(origin = {0, 48}, extent = {{30, -35}, {40, -25}}, rotation = 0)));
  Modelica.Blocks.Math.Add addFF(k1 = 1, k2 = Kff) annotation(
    Placement(visible = true, transformation(origin = {8, 40}, extent = {{48, -6}, {60, 6}}, rotation = 0)));
  Dynawo.NonElectrical.Blocks.Continuous.IntegratorSetFreeze I(K = unitTime, UseFreeze = true, Y0 = Xi0) annotation(
    Placement(visible = true, transformation(origin = {-14, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gainP(k = K) annotation(
    Placement(visible = true, transformation(origin = {-44, 50}, extent = {{20, -10}, {40, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiterI(strict = true, uMax = YMax, uMin = YMin) annotation(
    Placement(visible = true, transformation(origin = {-60, -14}, extent = {{70, -10}, {90, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gainI(k = K/Ti) annotation(
    Placement(visible = true, transformation(origin = {-104, -8}, extent = {{20, -10}, {40, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addArw(k1 = 1, k2 = 1) annotation(
    Placement(visible = true, transformation(origin = {22, -64}, extent = {{-80, 40}, {-60, 60}}, rotation = 0)));

equation

  connect(freeze, I.freeze) annotation(
    Line(points = {{-94, -124}, {-94, -95}, {-20, -95}, {-20, -26}}, color = {255, 0, 255}));
  connect(u_s, feedback.u1) annotation(
    Line(points = {{-120, 0}, {-96, 0}, {-96, 56}, {-66, 56}}, color = {0, 0, 127}));
  connect(u_m, feedback.u2) annotation(
    Line(points = {{0, -120}, {0, -92}, {-92, -92}, {-92, 44}, {-66, 44}}, color = {0, 0, 127}, thickness = 0.5));
  connect(FFzero.y, addFF.u2) annotation(
    Line(points = {{40.5, 18}, {48, 18}, {48, 36}, {55, 36}}, color = {0, 0, 127}));
  connect(addFF.u2, uFF) annotation(
    Line(points = {{55, 36}, {55, -92}, {60, -92}, {60, -120}}, color = {0, 0, 127}));
  connect(addPID.y, addFF.u1) annotation(
    Line(points = {{45, 44}, {55, 44}}, color = {0, 0, 127}));
  connect(gainP.y, addPID.u1) annotation(
    Line(points = {{-3, 50}, {22, 50}}, color = {0, 0, 127}));
  connect(addSat.u1, limiterI.y) annotation(
    Line(points = {{44, -38}, {44, -14}, {31, -14}}, color = {0, 0, 127}));
  connect(addSat.u2, limiterI.u) annotation(
    Line(points = {{32, -38}, {32, -32}, {4, -32}, {4, -14}, {8, -14}}, color = {0, 0, 127}));
  connect(feedback.y, gainP.u) annotation(
    Line(points = {{-43, 50}, {-26, 50}}, color = {0, 0, 127}));
  connect(I.y, limiterI.u) annotation(
    Line(points = {{-3, -14}, {8, -14}}, color = {0, 0, 127}));
  connect(gainTrack.y, addArw.u2) annotation(
    Line(points = {{-63, -46}, {-86, -46}, {-86, -20}, {-60, -20}}, color = {0, 0, 127}));
  connect(gainI.y, addArw.u1) annotation(
    Line(points = {{-63, -8}, {-60, -8}}, color = {0, 0, 127}));
  connect(addArw.y, I.u) annotation(
    Line(points = {{-37, -14}, {-26, -14}}, color = {0, 0, 127}));
  connect(addSat.y, gainTrack.u) annotation(
    Line(points = {{38, -60}, {38, -66}, {20, -66}, {20, -46}, {-40, -46}}, color = {0, 0, 127}));
  connect(feedback.y, gainI.u) annotation(
    Line(points = {{-42, 50}, {-40, 50}, {-40, 26}, {-88, 26}, {-88, -4}, {-86, -4}, {-86, -8}}, color = {0, 0, 127}));
  connect(limiterI.y, addPID.u2) annotation(
    Line(points = {{32, -14}, {44, -14}, {44, 4}, {14, 4}, {14, 38}, {22, 38}}, color = {0, 0, 127}));
  connect(addFF.y, y) annotation(
    Line(points = {{68, 40}, {80, 40}, {80, 0}, {110, 0}}, color = {0, 0, 127}));
  annotation(
    defaultComponentName = "PID",
    preferredView = "diagram",
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, 78}, {-80, -90}}, color = {192, 192, 192}), Polygon(points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-90, -80}, {82, -80}}, color = {192, 192, 192}), Polygon(points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-80, -20}, {30, 60}, {80, 60}}, color = {0, 0, 127}), Text(extent = {{-20, -20}, {80, -60}}, lineColor = {192, 192, 192}), Line(visible = Strict, points = {{30, 60}, {81, 60}}, color = {255, 0, 0})}),
    Diagram(graphics = {Text(textColor = {0, 0, 255}, extent = {{79, -112}, {129, -102}}, textString = " (feed-forward)")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Documentation(info = "<html>
The following features are present:
</p>
<ul>
<li> The output of this controller is limited. If the controller is
     in its limits, anti-windup compensation is activated to drive
     the integrator state to zero.</li>
<li> Setpoint weighting is present, which allows to weight
     the setpoint in the proportional part
     independently from the measurement. The controller will respond
     to load disturbances and measurement noise independently of this setting
     (parameters Wp). However, setpoint changes will depend on this
     setting.</li>
<li> Optional feed-forward. It is possible to add a feed-forward signal.
     The feed-forward signal is added before limitation.</li>
</ul>

<p>
<strong>Extended with Freeze functionality:</strong> If boolean input is set to true, the derivative of the state variable is set to zero.
</p>
</html>"));

end LimPIDFreeze_mod;
