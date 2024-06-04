within WindStandardModels.AdditionalModels.WECC;

model REGC_A "WECC Generator Control REGC_A"
  /*
      * Copyright (c) 2024, RTE (http://www.rte-france.com)
      * See AUTHORS.txt
      * All rights reserved.
      * This Source Code Form is subject to the terms of the Mozilla Public
      * License, v. 2.0. If a copy of the MPL was not distributed with this
      * file, you can obtain one at http://mozilla.org/MPL/2.0/.
      * SPDX-License-Identifier: MPL-2.0
      *
      */

  import WindStandardModels.AdditionalModels.WECC.Parameters_mod;
  extends WindStandardModels.AdditionalModels.WECC.Parameters_mod.Params_GeneratorControl;
  
  parameter Dynawo.Types.VoltageModulePu UInj0Pu "Start value of voltage amplitude at injector terminal in pu (base UNom)";
  parameter Dynawo.Types.CurrentModulePu Id0Pu "Start value of d-component current at injector terminal in pu (generator convention) (base SNom, UNom)";
  parameter Dynawo.Types.CurrentModulePu Iq0Pu "Start value of q-component current at injector terminal in pu (generator convention) (base SNom, UNom)";
  
  Modelica.Blocks.Interfaces.RealInput idCmdPu(start = Id0Pu) "idCmdPu setpoint from electrical control in pu (base SNom, UNom)" annotation(
    Placement(visible = true, transformation(origin = {-230, -85}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput iqCmdPu(start = Iq0Pu) "iqCmdPu setpoint from electrical control in pu (base SNom, UNom)" annotation(
    Placement(visible = true, transformation(origin = {-230, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput UPu(start = UInj0Pu) "Inverter terminal voltage magnitude in pu (base UNom)" annotation(
    Placement(visible = true, transformation(origin = {-230, 5}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{10, -10}, {-10, 10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealInput Qgen0(start = UInj0Pu) "Rective Power Setpoint in pu (base Iverter)" annotation(
    Placement(visible = true, transformation(origin = {-130, 200}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-60, 109}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput idRefPu(start = Id0Pu) "idRefPu setpoint to injector in pu (generator convention) (base SNom, UNom)" annotation(
    Placement(visible = true, transformation(origin = {290, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput iqRefPu(start = -Iq0Pu) "iqRefPu setpoint to injector in pu (generator convention) (base SNom, UNom)" annotation(
    Placement(visible = true, transformation(origin = {290, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold annotation(
    Placement(visible = true, transformation(origin = {-105, 128}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = -1) annotation(
    Placement(visible = true, transformation(origin = {111, 89}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant3(k = -9999) annotation(
    Placement(visible = true, transformation(origin = {-9, 29}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant4(k = 9999) annotation(
    Placement(visible = true, transformation(origin = {-9, 109}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Dynawo.NonElectrical.Blocks.Continuous.RateLimFirstOrderFreeze rateLimFirstOrderFreeze2(T = tG, UseRateLim = true, Y0 = Iq0Pu) annotation(
    Placement(visible = true, transformation(origin = {70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant5(k = IqrMaxPu) annotation(
    Placement(visible = true, transformation(origin = {-9, 149}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant6(k = IqrMinPu) annotation(
    Placement(visible = true, transformation(origin = {-9, 69}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch3 annotation(
    Placement(visible = true, transformation(origin = {31, 49}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch4 annotation(
    Placement(visible = true, transformation(origin = {31, 129}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not1 annotation(
    Placement(visible = true, transformation(origin = {-65, 101}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Dynawo.NonElectrical.Blocks.NonLinear.VariableLimiter variableLimiter annotation(
    Placement(visible = true, transformation(origin = {25, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = -9999) annotation(
    Placement(visible = true, transformation(origin = {-5.5, -113.5}, extent = {{-7.5, -7.5}, {7.5, 7.5}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {-14, -29}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant2(k = 9999) annotation(
    Placement(visible = true, transformation(origin = {-49.5, -46.5}, extent = {{-7.5, -7.5}, {7.5, 7.5}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = Lvplsw) annotation(
    Placement(visible = true, transformation(origin = {-159, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant RrpwrNeg0(k = -9999) annotation(
    Placement(visible = true, transformation(origin = {-95, -105}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Dynawo.NonElectrical.Blocks.Continuous.RateLimFirstOrderFreeze rateLimFirstOrderFreeze1(T = tG, UseRateLim = true, Y0 = Id0Pu*UInj0Pu, k = 1) annotation(
    Placement(visible = true, transformation(origin = {-55, -85}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant RrpwrPos0(k = Rrpwr) annotation(
    Placement(visible = true, transformation(origin = {-96, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = tFilterGC, k = 1, y(start = UInj0Pu), y_start = UInj0Pu) annotation(
    Placement(visible = true, transformation(origin = {-158, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  WindStandardModels.AdditionalModels.WECC.LowVoltagePowerLogic lowVoltagePowerLogic(brkpt = brkpt, lvpl1 = lvpl1, zerox = zerox) annotation(
    Placement(visible = true, transformation(origin = {-99, -12}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
equation
  
  connect(switch3.y, rateLimFirstOrderFreeze2.dyMin) annotation(
    Line(points = {{42, 49}, {45, 49}, {45, 84}, {58, 84}}, color = {0, 0, 127}));
  connect(constant6.y, switch3.u1) annotation(
    Line(points = {{2, 69}, {11, 69}, {11, 57}, {19, 57}}, color = {0, 0, 127}));
  connect(constant5.y, switch4.u1) annotation(
    Line(points = {{2, 149}, {11, 149}, {11, 137}, {19, 137}}, color = {0, 0, 127}));
  connect(constant4.y, switch4.u3) annotation(
    Line(points = {{2, 109}, {11, 109}, {11, 121}, {19, 121}}, color = {0, 0, 127}));
  connect(rateLimFirstOrderFreeze2.y, gain1.u) annotation(
    Line(points = {{81, 90}, {90.5, 90}, {90.5, 89}, {99, 89}}, color = {0, 0, 127}));
  connect(constant3.y, switch3.u3) annotation(
    Line(points = {{2, 29}, {11, 29}, {11, 41}, {19, 41}, {19, 41}}, color = {0, 0, 127}));
  connect(switch4.y, rateLimFirstOrderFreeze2.dyMax) annotation(
    Line(points = {{42, 129}, {45, 129}, {45, 97}, {58, 97}}, color = {0, 0, 127}));
  connect(greaterThreshold.y, switch4.u2) annotation(
    Line(points = {{-94, 128}, {-37.5, 128}, {-37.5, 129}, {19, 129}}, color = {255, 0, 255}));
  connect(not1.y, switch3.u2) annotation(
    Line(points = {{-54, 101}, {-54, 49}, {19, 49}}, color = {255, 0, 255}));
  connect(greaterThreshold.y, not1.u) annotation(
    Line(points = {{-94, 128}, {-84, 128}, {-84, 101}, {-77, 101}}, color = {255, 0, 255}));
  connect(iqCmdPu, rateLimFirstOrderFreeze2.u) annotation(
    Line(points = {{-230, 60}, {-47, 60}, {-47, 90}, {58, 90}}, color = {0, 0, 127}));
  connect(constant1.y, variableLimiter.limit2) annotation(
    Line(points = {{2.75, -113.5}, {2.75, -92}, {13, -92}}, color = {0, 0, 127}));
  connect(Qgen0, greaterThreshold.u) annotation(
    Line(points = {{-130, 200}, {-130, 128}, {-117, 128}}, color = {0, 0, 127}));
  connect(booleanConstant.y, switch1.u2) annotation(
    Line(points = {{-148, -44}, {-75.5, -44}, {-75.5, -29}, {-26, -29}}, color = {255, 0, 255}));
  connect(RrpwrPos0.y, rateLimFirstOrderFreeze1.dyMax) annotation(
    Line(points = {{-85, -64}, {-76, -64}, {-76, -78}, {-67, -78}}, color = {0, 0, 127}));
  connect(RrpwrNeg0.y, rateLimFirstOrderFreeze1.dyMin) annotation(
    Line(points = {{-84, -105}, {-74, -105}, {-74, -91}, {-67, -91}}, color = {0, 0, 127}));
  connect(idCmdPu, rateLimFirstOrderFreeze1.u) annotation(
    Line(points = {{-230, -85}, {-67, -85}}, color = {0, 0, 127}));
  connect(switch1.y, variableLimiter.limit1) annotation(
    Line(points = {{-3, -29}, {6, -29}, {6, -76}, {13, -76}}, color = {0, 0, 127}));
  connect(constant2.y, switch1.u3) annotation(
    Line(points = {{-41, -46}, {-36, -46}, {-36, -37}, {-26, -37}}, color = {0, 0, 127}));
  connect(firstOrder.u, UPu) annotation(
    Line(points = {{-170, -12}, {-185, -12}, {-185, 5}, {-230, 5}}, color = {0, 0, 127}));
  connect(firstOrder.y, lowVoltagePowerLogic.UPu) annotation(
    Line(points = {{-147, -12}, {-116, -12}}, color = {0, 0, 127}));
  connect(lowVoltagePowerLogic.LVPL, switch1.u1) annotation(
    Line(points = {{-82, -12}, {-50, -12}, {-50, -21}, {-26, -21}}, color = {0, 0, 127}));
  connect(rateLimFirstOrderFreeze1.y, variableLimiter.u) annotation(
    Line(points = {{-44, -85}, {-15.5, -85}, {-15.5, -84}, {13, -84}}, color = {0, 0, 127}));
  connect(gain1.y, iqRefPu) annotation(
    Line(points = {{122, 89}, {254, 89}, {254, 80}, {290, 80}}, color = {0, 0, 127}));
  connect(variableLimiter.y, idRefPu) annotation(
    Line(points = {{36, -84}, {256, -84}, {256, -70}, {290, -70}}, color = {0, 0, 127}));
  annotation(
    preferredView = "diagram",
    Documentation(info = "<html>

<p> The block calculates the final setpoints for Iq and Id while considering ramp rates for reactive current and active current (or active power if RampFlag is true).


</ul> </p></html>"),
    Diagram(coordinateSystem(initialScale = 0.2, extent = {{-220, 190}, {280, -130}}, grid = {1, 1}), graphics = {Rectangle(origin = {200, 90}, extent = {{-31, 40}, {31, -40}}), Text(origin = {201, 87.5}, extent = {{-25, 23}, {25, -22}}, textString = "high voltage 
reactive current
management"), Rectangle(origin = {197, -70}, extent = {{-31, 40}, {31, -40}}), Text(origin = {201, -70.5}, extent = {{-25, 23}, {25, -22}}, textString = "low voltage 
active current
management")}),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-25, 20}, extent = {{-53, 60}, {107, -100}}, textString = "REGC_A"), Text(origin = {134, -42}, extent = {{-22, 16}, {36, -28}}, textString = "idRefPu"), Text(origin = {134, 62}, extent = {{-22, 16}, {36, -32}}, textString = "iqRefPu"), Text(origin = {-138, 82}, extent = {{-22, 16}, {36, -28}}, textString = "idCmdPu"), Text(origin = {-138, -38}, extent = {{-22, 16}, {36, -28}}, textString = "iqCmdPu"), Text(origin = {-33, -108}, extent = {{25, 10}, {-25, -10}}, textString = "UPu"), Text(origin = {-5, 123}, extent = {{43, -9}, {-43, 9}}, textString = "Qgen0")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));

end REGC_A;
