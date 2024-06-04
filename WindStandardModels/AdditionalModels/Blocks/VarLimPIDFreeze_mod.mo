within WindStandardModels.AdditionalModels.Blocks;

model VarLimPIDFreeze_mod "PI controller with limited output (with adjustable limits), anti-windup compensation, setpoint weighting, optional feed-forward and optional freezing of the state"
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
  parameter Dynawo.Types.Time Ti = 0.5 "Time constant of Integrator block";
  parameter Real Wp = 1 "Set-point weight for Proportional block (0..1)";
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
  
  output Real controlError = u_s - u_m "Control error (set point - measurement)";
  constant Dynawo.Types.Time unitTime = 1 annotation(
    HideResult = true);
  Modelica.Blocks.Interfaces.RealInput uFF if WithFeedForward "Optional connector of feed-forward input signal" annotation(
    Placement(transformation(origin = {60, -120}, extent = {{20, -20}, {-20, 20}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealInput yMin annotation(
    Placement(visible = true, transformation(origin = {-120, -62}, extent = {{20, -20}, {-20, 20}}, rotation = 180), iconTransformation(origin = {-120, -62}, extent = {{20, -20}, {-20, 20}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealInput yMax annotation(
    Placement(visible = true, transformation(origin = {-120, 92}, extent = {{20, -20}, {-20, 20}}, rotation = 180), iconTransformation(origin = {-120, 64}, extent = {{20, -20}, {-20, 20}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanInput freeze annotation(
    Placement(visible = true, transformation(origin = {-94, -124}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-68, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Math.Add feedback(k1 = 1, k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {0, 24}, extent = {{-80, 40}, {-60, 60}}, rotation = 0)));
  Modelica.Blocks.Math.Add addPID annotation(
    Placement(visible = true, transformation(origin = {44, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addSat(k1 = +1, k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {4, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Math.Gain gainTrack(k = Ni) annotation(
    Placement(visible = true, transformation(origin = {-58, 48}, extent = {{0, -80}, {-20, -60}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant FFzero(k = 0) if not WithFeedForward annotation(
    Placement(transformation(extent = {{30, -35}, {40, -25}})));
  Modelica.Blocks.Math.Add addFF(k1 = 1, k2 = Kff) annotation(
    Placement(visible = true, transformation(origin = {0, 44}, extent = {{48, -6}, {60, 6}}, rotation = 0)));
  Dynawo.NonElectrical.Blocks.Continuous.IntegratorSetFreeze I(K = unitTime, UseFreeze = true, Y0 = Xi0) annotation(
    Placement(visible = true, transformation(origin = {-34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gainP(k = K) annotation(
    Placement(visible = true, transformation(origin = {-38, 74}, extent = {{20, -10}, {40, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gainI(k = K/Ti) annotation(
    Placement(visible = true, transformation(origin = {-102, 44}, extent = {{20, -10}, {40, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter annotation(
    Placement(visible = true, transformation(origin = {-76, 12}, extent = {{70, -10}, {90, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addArw(k1 = 1, k2 = 1) annotation(
    Placement(visible = true, transformation(origin = {2, -38}, extent = {{-80, 40}, {-60, 60}}, rotation = 0)));

equation

  connect(freeze, I.freeze) annotation(
    Line(points = {{-94, -124}, {-94, -95}, {-40, -95}, {-40, 0}}, color = {255, 0, 255}));
  connect(u_s, feedback.u1) annotation(
    Line(points = {{-120, 0}, {-96, 0}, {-96, 80}, {-82, 80}}, color = {0, 0, 127}));
  connect(u_m, feedback.u2) annotation(
    Line(points = {{0, -120}, {0, -92}, {-92, -92}, {-92, 68}, {-82, 68}}, color = {0, 0, 127}, thickness = 0.5));
  connect(FFzero.y, addFF.u2) annotation(
    Line(points = {{40.5, -30}, {44, -30}, {44, 40}, {47, 40}}, color = {0, 0, 127}));
  connect(addFF.u2, uFF) annotation(
    Line(points = {{47, 40}, {44, 40}, {44, -92}, {60, -92}, {60, -120}}, color = {0, 0, 127}));
  connect(feedback.y, gainP.u) annotation(
    Line(points = {{-59, 74}, {-20, 74}}, color = {0, 0, 127}));
  connect(gainP.y, addPID.u1) annotation(
    Line(points = {{4, 74}, {32, 74}}, color = {0, 0, 127}));
  connect(addPID.y, addFF.u1) annotation(
    Line(points = {{56, 68}, {60, 68}, {60, 54}, {40, 54}, {40, 48}, {46, 48}}, color = {0, 0, 127}));
  connect(variableLimiter.limit1, yMax) annotation(
    Line(points = {{-8, 20}, {-19, 20}, {-19, 50}, {-30, 50}, {-30, 92}, {-120, 92}}, color = {0, 0, 127}));
  connect(feedback.y, gainI.u) annotation(
    Line(points = {{-58, 74}, {-52, 74}, {-52, 58}, {-90, 58}, {-90, 44}, {-84, 44}}, color = {0, 0, 127}));
  connect(addArw.y, I.u) annotation(
    Line(points = {{-56, 12}, {-46, 12}}, color = {0, 0, 127}));
  connect(gainI.y, addArw.u1) annotation(
    Line(points = {{-60, 44}, {-52, 44}, {-52, 28}, {-88, 28}, {-88, 18}, {-80, 18}}, color = {0, 0, 127}));
  connect(gainTrack.y, addArw.u2) annotation(
    Line(points = {{-79, -22}, {-86, -22}, {-86, 6}, {-80, 6}}, color = {0, 0, 127}));
  connect(I.y, variableLimiter.u) annotation(
    Line(points = {{-23, 12}, {-8, 12}}, color = {0, 0, 127}));
  connect(yMin, variableLimiter.limit2) annotation(
    Line(points = {{-120, -62}, {-98, -62}, {-98, -88}, {-12, -88}, {-12, 4}, {-8, 4}}, color = {0, 0, 127}));
  connect(addSat.u2, I.y) annotation(
    Line(points = {{-2, -10}, {-2, -4}, {-18, -4}, {-18, 12}, {-22, 12}}, color = {0, 0, 127}));
  connect(addSat.u1, variableLimiter.y) annotation(
    Line(points = {{10, -10}, {10, 0}, {20, 0}, {20, 12}, {16, 12}}, color = {0, 0, 127}));
  connect(variableLimiter.y, addPID.u2) annotation(
    Line(points = {{16, 12}, {26, 12}, {26, 62}, {32, 62}}, color = {0, 0, 127}));
  connect(addSat.y, gainTrack.u) annotation(
    Line(points = {{4, -32}, {4, -40}, {-48, -40}, {-48, -22}, {-56, -22}}, color = {0, 0, 127}));
  connect(addFF.y, y) annotation(
    Line(points = {{60, 44}, {78, 44}, {78, 0}, {110, 0}}, color = {0, 0, 127}));
  annotation(
    defaultComponentName = "PI",
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, 78}, {-80, -90}}, color = {192, 192, 192}), Polygon(points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-90, -80}, {82, -80}}, color = {192, 192, 192}), Polygon(points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-80, -20}, {30, 60}, {80, 60}}, color = {0, 0, 127}), Text(extent = {{-20, -20}, {80, -60}}, lineColor = {192, 192, 192}), Line(visible = Strict, points = {{30, 60}, {81, 60}}, color = {255, 0, 0})}),
    Diagram(graphics = {Text(textColor = {0, 0, 255}, extent = {{79, -112}, {129, -102}}, textString = " (feed-forward)")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Documentation(info = "<html>

<p>
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

end VarLimPIDFreeze_mod;