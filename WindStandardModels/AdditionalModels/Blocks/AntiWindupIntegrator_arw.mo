within WindStandardModels.AdditionalModels.Blocks;

block AntiWindupIntegrator_arw "Integrator with absolute and rate limits, anti windup and anti winddown"
  /*
  * Copyright (c) 2024, RTE (http://www.rte-france.com)
  * See AUTHORS.txt
  * All rights reserved.
  * This Source Code Form is subject to the terms of the Mozilla Public
  * License, v. 2.0. If a copy of the MPL was not distributed with this
  * file, you can obtain one at http://mozilla.org/MPL/2.0/.
  * SPDX-License-Identifier: MPL-2.0
  *
  *
  */
  extends Modelica.Blocks.Icons.Block;
  
  parameter Real K = 1 "Gain of controller";
  parameter Real Ni = 0.9 "Ni*Ti is time constant of anti-windup compensation";
  parameter Dynawo.Types.PerUnit DyMax "Maximum rising slew rate of output";
  parameter Dynawo.Types.PerUnit DyMin = -DyMax "Maximum falling slew rate of output";
  parameter Dynawo.Types.Time tI "Integrator time constant in s";
  parameter Dynawo.Types.PerUnit YMax "Upper limit of output";
  parameter Dynawo.Types.PerUnit YMin = -YMax "Lower limit of output";
  parameter Dynawo.Types.PerUnit Y0 "Initial value of output";
  
  Modelica.Blocks.Interfaces.BooleanInput fMax(start = false) "True if anti windup should be applied" annotation(
    Placement(visible = true, transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {80, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput u "Input signal connector" annotation(
    Placement(visible = true, transformation(origin = {-220, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y(start = Y0) "Output signal connector" annotation(
    Placement(visible = true, transformation(origin = {210, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1/tI) annotation(
    Placement(visible = true, transformation(origin = {-170, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = DyMax, uMin = DyMin) annotation(
    Placement(visible = true, transformation(origin = {-130, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator(y_start = Y0) annotation(
    Placement(visible = true, transformation(origin = {130, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax = YMax, uMin = YMin) annotation(
    Placement(visible = true, transformation(origin = {170, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Max max annotation(
    Placement(visible = true, transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Min min annotation(
    Placement(visible = true, transformation(origin = {10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation(
    Placement(visible = true, transformation(origin = {64, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addSat(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {170, -46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Gain gainTrack(k = Ni) annotation(
    Placement(visible = true, transformation(origin = {140, -64}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addArw annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput fMin(start = false) annotation(
    Placement(visible = true, transformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));

equation
  connect(gain.y, limiter.u) annotation(
    Line(points = {{-159, 0}, {-142, 0}}, color = {0, 0, 127}));
  connect(limiter1.y, y) annotation(
    Line(points = {{181, 0}, {210, 0}}, color = {0, 0, 127}));
  connect(integrator.y, limiter1.u) annotation(
    Line(points = {{141, 0}, {158, 0}}, color = {0, 0, 127}));
  connect(u, gain.u) annotation(
    Line(points = {{-220, 0}, {-182, 0}}, color = {0, 0, 127}));
  connect(const.y, max.u2) annotation(
    Line(points = {{-98, -60}, {-90, -60}, {-90, -46}, {-82, -46}}, color = {0, 0, 127}));
  connect(limiter.y, max.u1) annotation(
    Line(points = {{-119, 0}, {-90, 0}, {-90, -34}, {-82, -34}}, color = {0, 0, 127}));
  connect(max.y, switch1.u1) annotation(
    Line(points = {{-59, -40}, {-50, -40}, {-50, -8}, {-42, -8}}, color = {0, 0, 127}));
  connect(limiter.y, switch1.u3) annotation(
    Line(points = {{-119, 0}, {-80, 0}, {-80, 8}, {-42, 8}}, color = {0, 0, 127}));
  connect(switch1.y, switch2.u3) annotation(
    Line(points = {{-18, 0}, {20, 0}, {20, -8}, {52, -8}}, color = {0, 0, 127}));
  connect(switch1.y, min.u2) annotation(
    Line(points = {{-18, 0}, {-10, 0}, {-10, 44}, {-2, 44}}, color = {0, 0, 127}));
  connect(const.y, min.u1) annotation(
    Line(points = {{-98, -60}, {-94, -60}, {-94, 56}, {-2, 56}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(min.y, switch2.u1) annotation(
    Line(points = {{22, 50}, {40, 50}, {40, 8}, {52, 8}}, color = {0, 0, 127}));
  connect(fMax, switch2.u2) annotation(
    Line(points = {{0, 120}, {0, 80}, {32, 80}, {32, 0}, {52, 0}}, color = {255, 0, 255}));
  connect(limiter1.y, addSat.u1) annotation(
    Line(points = {{182, 0}, {186, 0}, {186, -28}, {176, -28}, {176, -34}}, color = {0, 0, 127}));
  connect(integrator.y, addSat.u2) annotation(
    Line(points = {{142, 0}, {150, 0}, {150, -28}, {164, -28}, {164, -34}}, color = {0, 0, 127}));
  connect(addSat.y, gainTrack.u) annotation(
    Line(points = {{170, -56}, {170, -64}, {152, -64}}, color = {0, 0, 127}));
  connect(switch2.y, addArw.u1) annotation(
    Line(points = {{75, 0}, {75, 6}, {88, 6}}, color = {0, 0, 127}));
  connect(addArw.y, integrator.u) annotation(
    Line(points = {{112, 0}, {118, 0}}, color = {0, 0, 127}));
  connect(gainTrack.y, addArw.u2) annotation(
    Line(points = {{130, -64}, {80, -64}, {80, -6}, {88, -6}}, color = {0, 0, 127}));
  connect(fMin, switch1.u2) annotation(
    Line(points = {{0, -120}, {0, -20}, {-60, -20}, {-60, 0}, {-42, 0}}, color = {255, 0, 255}));
  annotation(
    preferredView = "diagram",
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Line(origin = {-40, 1.06}, points = {{-40, -121.057}, {20, 118.943}}), Line(origin = {40, 1.05741}, points = {{-80, -121.057}, {-40, -121.057}, {20, 118.943}, {60, 118.943}}), Rectangle(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {12, 28}, extent = {{-44, 34}, {26, -16}}, textString = "1"), Text(origin = {2, -44}, extent = {{-60, 22}, {60, -22}}, textString = "sT"), Line(origin = {4, 0}, points = {{-86, 0}, {86, 0}})}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));

end AntiWindupIntegrator_arw;