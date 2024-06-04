within WindStandardModels.AdditionalModels.WECC;

model WT4BCurrentSource_mod "WECC Wind Turbine model with a current source as interface with the grid"
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

  import Dynawo.Electrical.SystemBase;
  import WindStandardModels.AdditionalModels.WECC.Parameters_mod;
  extends WindStandardModels.AdditionalModels.WECC.Parameters_mod.Params_PlantControl;
  extends WindStandardModels.AdditionalModels.WECC.Parameters_mod.Params_ElectricalControl;
  extends WindStandardModels.AdditionalModels.WECC.Parameters_mod.Params_GeneratorControl;
  extends WindStandardModels.AdditionalModels.WECC.Parameters_mod.Params_PLL;
  
  parameter Dynawo.Types.ApparentPowerModule SNom "Nominal apparent power in MVA";
  parameter Dynawo.Types.PerUnit RPu "Resistance of equivalent branch connection to the grid in pu (base SnRef, UNom)";
  parameter Dynawo.Types.PerUnit XPu "Reactance of equivalent branch connection to the grid in pu (base SnRef, UNom)";
  parameter Real VDLIp11;
  parameter Real VDLIp12;
  parameter Real VDLIp21;
  parameter Real VDLIp22;
  parameter Real VDLIp31;
  parameter Real VDLIp32;
  parameter Real VDLIp41;
  parameter Real VDLIp42;
  parameter Real VDLIq11;
  parameter Real VDLIq12;
  parameter Real VDLIq21;
  parameter Real VDLIq22;
  parameter Real VDLIq31;
  parameter Real VDLIq32;
  parameter Real VDLIq41;
  parameter Real VDLIq42;
  parameter Dynawo.Types.PerUnit VRef1Pu "User-defined reference/bias on the inner-loop voltage control (typical: 0 pu)";
  parameter Dynawo.Types.Time HoldIpMax "Time delay for which the active current limit (ipMaxPu) is held after voltage dip vDip returns to zero for HoldIpMax seconds at its value during the voltage dip";
  parameter Real HoldIq "Absolute value of HoldIq defines seconds to hold current injection after voltage dip ended. HoldIq < 0 for constant, 0 for no injection after voltage dip, HoldIq > 0 for voltage-dependent injection (typical: -1 .. 1 s)";
  parameter Dynawo.Types.PerUnit IqFrzPu "Constant reactive current injection value (typical: -0.1 .. 0.1 pu)";
  parameter Boolean PFlag "Power reference flag: const. Pref (0) or consider generator speed (1)";
  
  Dynawo.Connectors.ACPower terminal(V(re(start = u0Pu.re), im(start = u0Pu.im)), i(re(start = i0Pu.re), im(start = i0Pu.im))) annotation(
    Placement(visible = true, transformation(origin = {180, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {100, 8.88178e-16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput PRefPu(start = -P0Pu*SystemBase.SnRef/SNom) "Active power reference in pu (generator convention) (base SNom)" annotation(
    Placement(visible = true, transformation(origin = {-110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput QRefPu(start = -Q0Pu*SystemBase.SnRef/SNom) "Reactive power reference in pu (generator convention) (base SNom)" annotation(
    Placement(visible = true, transformation(origin = {-110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  WindStandardModels.AdditionalModels.WECC.ElectricalControlWind_mod wecc_reec(DPMax = DPMax, DPMin = DPMin, Dbd1 = Dbd1, Dbd2 = Dbd2, HoldIpMax = HoldIpMax, HoldIq = HoldIq, IMaxPu = IMaxPu, Id0Pu = Id0Pu, Iq0Pu = Iq0Pu, IqFrzPu = IqFrzPu, Iqh1Pu = Iqh1Pu, Iql1Pu = Iql1Pu, Kqi = Kqi, Kqp = Kqp, Kqv = Kqv, Kvi = Kvi, Kvp = Kvp, Ni = Ni, PF0 = PF0, PFlag = PFlag, PInj0Pu = PInj0Pu, PMaxPu = PMaxPu, PMinPu = PMinPu, PPriority = PPriority, PfFlag = PfFlag, QFlag = QFlag, QInj0Pu = QInj0Pu, QMaxPu = QMaxPu, QMinPu = QMinPu, Tiq = Tiq, UInj0Pu = UInj0Pu, UMaxPu = UMaxPu, UMinPu = UMinPu, VDLIp11 = VDLIp11, VDLIp12 = VDLIp12, VDLIp21 = VDLIp21, VDLIp22 = VDLIp22, VDLIp31 = VDLIp31, VDLIp32 = VDLIp32, VDLIp41 = VDLIp41, VDLIp42 = VDLIp42, VDLIq11 = VDLIq11, VDLIq12 = VDLIq12, VDLIq21 = VDLIq21, VDLIq22 = VDLIq22, VDLIq31 = VDLIq31, VDLIq32 = VDLIq32, VDLIq41 = VDLIq41, VDLIq42 = VDLIq42, VFlag = VFlag, VMaxPu = VMaxPu, VMinPu = VMinPu, VRef0Pu = VRef0Pu, VRef1Pu = VRef1Pu, tP = tP, tPord = tPord, tRv = tRv) annotation(
    Placement(visible = true, transformation(origin = {-5.13151, -18.1384}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Dynawo.Electrical.Sources.InjectorIDQ injector(Id0Pu = Id0Pu, Iq0Pu = Iq0Pu, P0Pu = -PInj0Pu*(SNom/SystemBase.SnRef), Q0Pu = -QInj0Pu*(SNom/SystemBase.SnRef), SNom = SNom, U0Pu = UInj0Pu, UPhase0 = UPhaseInj0, i0Pu = i0Pu, s0Pu = s0Pu, u0Pu = uInj0Pu) annotation(
    Placement(visible = true, transformation(origin = {80, -18}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant omegaG(k = 1) annotation(
    Placement(visible = true, transformation(origin = {40, -45}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  WindStandardModels.AdditionalModels.WECC.REGC_A regc_a(IqrMaxPu = IqrMaxPu, IqrMinPu = IqrMinPu, RateFlag = RateFlag, Rrpwr = Rrpwr, tFilterGC = tFilterGC, tG = tG, UInj0Pu = UInj0Pu, Id0Pu = Id0Pu, Iq0Pu = Iq0Pu) annotation(
    Placement(visible = true, transformation(origin = {39, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-55, -83}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));

  parameter Dynawo.Types.PerUnit P0Pu "Start value of active power at regulated bus in pu (receptor convention) (base SnRef)";
  parameter Dynawo.Types.PerUnit Q0Pu "Start value of reactive power at regulated bus in pu (receptor convention) (base SnRef)";
  parameter Dynawo.Types.PerUnit U0Pu "Start value of voltage magnitude at regulated bus in pu (base UNom)";
  parameter Dynawo.Types.ComplexPerUnit u0Pu "Start value of complex voltage at terminal in pu (base UNom)";
  parameter Dynawo.Types.ComplexPerUnit s0Pu "Start value of complex apparent power at terminal in pu (base SnRef) (receptor convention)";
  parameter Dynawo.Types.ComplexPerUnit i0Pu "Start value of complex current at terminal in pu (base UNom, SnRef) (receptor convention)";
  parameter Dynawo.Types.ComplexPerUnit iInj0Pu "Start value of complex current at injector in pu (base UNom, SNom) (generator convention)";
  parameter Dynawo.Types.ComplexPerUnit uInj0Pu "Start value of complex voltage at injector in pu (base UNom)";
  parameter Dynawo.Types.Angle UPhaseInj0 "Start value of voltage angle at injector";

equation

  connect(injector.UPu, wecc_reec.UPu) annotation(
    Line(points = {{92, -26}, {97, -26}, {97, -34}, {1, -34}, {1, -29}}, color = {0, 0, 127}));
  connect(injector.PInjPuSn, wecc_reec.PInjPu) annotation(
    Line(points = {{92, -22}, {99, -22}, {99, -36}, {-5, -36}, {-5, -29}}, color = {0, 0, 127}));
  connect(omegaG.y, wecc_reec.omegaGPu) annotation(
    Line(points = {{34.5, -45}, {-10, -45}, {-10, -29}}, color = {0, 0, 127}));
  connect(QRefPu, wecc_reec.QInjRefPu) annotation(
    Line(points = {{-110, -40}, {-35, -40}, {-35, -24}, {-16, -24}}, color = {0, 0, 127}));
  connect(PRefPu, wecc_reec.PInjRefPu) annotation(
    Line(points = {{-110, -20}, {-38, -20}, {-38, -12}, {-16, -12}}, color = {0, 0, 127}));
  connect(wecc_reec.idCmdPu, regc_a.idCmdPu) annotation(
    Line(points = {{6, -12}, {28, -12}}, color = {0, 0, 127}));
  connect(wecc_reec.iqCmdPu, regc_a.iqCmdPu) annotation(
    Line(points = {{6, -24}, {28, -24}}, color = {0, 0, 127}));
  connect(regc_a.iqRefPu, injector.iqPu) annotation(
    Line(points = {{50, -14}, {69, -14}}, color = {0, 0, 127}));
  connect(regc_a.idRefPu, injector.idPu) annotation(
    Line(points = {{50, -24}, {69, -24}}, color = {0, 0, 127}));
  connect(injector.UPu, regc_a.UPu) annotation(
    Line(points = {{92, -26}, {97, -26}, {97, -34}, {39, -34}, {39, -29}}, color = {0, 0, 127}));
  connect(QRefPu, regc_a.Qgen0) annotation(
    Line(points = {{-110, -40}, {-82, -40}, {-82, 5}, {33, 5}, {33, -7}}, color = {0, 0, 127}));
  connect(injector.terminal, terminal) annotation(
    Line(points = {{92, -10}, {180, -10}}, color = {0, 0, 255}));
  connect(injector.QInjPuSn, wecc_reec.QInjPu) annotation(
    Line(points = {{92, -18}, {102, -18}, {102, -55}, {-14, -55}, {-14, -29}}, color = {0, 0, 127}));
  annotation(
    Documentation(preferredView = "diagram", info = "<html>
<p> This block contains the generic WECC WTG model according to (in case page cannot be found, copy link in browser): <br><a href=\"https://www.wecc.org/Reliability/WECC-Second-Generation-Wind-Turbine-Models-012314.pdf\">https://www.wecc.org/Reliability/WECC-Second-Generation-Wind-Turbine-Models-012314.pdf</a> </p>
<p> The overall model is structured as follows:
<ul>
<li> Main model: WECC_Wind with terminal connection and measurement inputs for P/Q/U/I. </li>
<li> Plant level control. </li>
<li> Electrical inverter control.</li>
<li> Constant speed of drive train represented by constant block (no drive train).</li>
<li> Generator control. </li>
<li> Injector (id,iq). </li>
</ul> </p></html>"),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-24, 11}, extent = {{-48, 27}, {98, -53}}, textString = "WECC WT 4B")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(grid = {1, 1}, extent = {{-100, -60}, {170, 50}})));

end WT4BCurrentSource_mod;