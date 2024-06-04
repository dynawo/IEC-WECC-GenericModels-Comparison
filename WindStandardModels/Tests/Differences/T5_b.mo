within WindStandardModels.Tests.Differences;

model T5_b "Fault with an impedance with dynamics neglegted"
  extends Modelica.Icons.Example;
  
  WindStandardModels.AdditionalModels.IEC.WT4ACurrentSource_mod wT4ACurrentSource(BesPu = 0, DPMaxP4APu = 100, DPRefMax4APu = 100, DPRefMin4APu = -100, DUdb1Pu = -0.1, DUdb2Pu = 0.1, DfMaxPu = 1, DipMaxPu = 100, DiqMaxPu = 100, DiqMinPu = -100, GesPu = 0, IGsIm0Pu = 0, IGsRe0Pu = 1, IMaxDipPu = 1.1, IMaxPu = 1.1, IpMax0Pu = 1.2, IqH1Pu = 1.1, IqMax0Pu = 0.4, IqMaxPu = 1.1, IqMin0Pu = -0.4, IqMinPu = -1.1, IqPostPu = 0, Kipaw = 100, Kiq = 2.25, Kiqaw = 100, Kiu = 10, Kpaw = 1000, Kpq = 1.1, Kpqu = 20, Kpu = 2, Kpufrt = 2, Kqv = 2, MdfsLim = false, MpUScale = false, MqG = 1, Mqfrt = 1, Mqpri = true, P0Pu = -1, PAg0Pu = 1, Q0Pu = 0, QMax0Pu = 0.4, QMaxPu = 0.8, QMin0Pu = -0.4, QMinPu = -0.8, QlConst = true, RDropPu = 0, ResPu = 0, SNom = 100, U0Pu = 1, UGsIm0Pu = 0, UGsRe0Pu = 1, UMaxPu = 1.1, UMinPu = 0.9, UOverPu = 999, UPhase0 = 0, UPll1Pu = 999, UPll2Pu = 0.13, URef0Pu = 0, UUnderPu = 1e-3, UpDipPu = 0, UpquMaxPu = 999, UqDipPu = 0.9, UqRisePu = 1.1, XDropPu = 0, XWT0Pu = 0, XesPu = 0, fOverPu = 999, fUnderPu = 1e-3, i0Pu = Complex(1, 0), tG = 1e-9, tIFilt = 0.01, tPFilt = 0.01, tPOrdP4A = 1e-9, tPWTRef4A = 0.00000001, tPll = 0.000000001, tPost = 0.1, tQFilt = 0.000001, tQord = 0.05, tS = 0.001, tUFilt = 0.01, tUss = 30, tfFilt = 0.01, u0Pu = Complex(1, 0)) annotation(
    Placement(visible = true, transformation(origin = {-48, 28}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Dynawo.Electrical.Lines.Line line_IEC(BPu = 0, GPu = 0, RPu = 0, XPu = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-12, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step pWTrefPu(height = 0, offset = 1, startTime = 1) annotation(
    Placement(visible = true, transformation(origin = {-106, 36}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Step xWTrefPu(height = 0, offset = 0, startTime = 0) annotation(
    Placement(visible = true, transformation(origin = {-106, 16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Step omegaRefPu(height = 0, offset = 1, startTime = 0) annotation(
    Placement(visible = true, transformation(origin = {-126, 74}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Dynawo.Electrical.Lines.Line line_WECC(BPu = 0, GPu = 0, RPu = 0, XPu = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-16, -26}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant tanPhi annotation(
    Placement(visible = true, transformation(origin = {-126, 54}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  WindStandardModels.AdditionalModels.WECC.WT4BCurrentSource_mod WECC_WT4B(DDn = 20, DPMax = 100, DPMin = -100, DUp = 0, Dbd = 0.05, Dbd1 = -0.1, Dbd2 = 0.1, EMax = 0.01, EMin = -0.01, FDbd1 = 0.01, FDbd2 = 0.01, FEMax = 0.05, FEMin = -0.05, FreqFlag = false, HoldIpMax (displayUnit = "ks")= 0, HoldIq = -0.1, IMaxPu = 1.1, Id0Pu = 1, Iq0Pu = 0, IqFrzPu = 0, Iqh1Pu = 1.1, Iql1Pu = -1.1, IqrMaxPu = 100, IqrMinPu = -100, Kc = 2, Ki = 1, Kig = 1, Kp = 1, Kpg = 1, Kqi = 2.25, Kqp = 1.1, Kqv = 2, Kvi = 10, Kvp = 2, Lvplsw = false, P0Pu = -1, PF0 = 1, PFlag = true, PInj0Pu = 1, PMaxPu = 1, PMinPu = 0, PPriority = false, PfFlag = false, Q0Pu = 0, QFlag = true, QInj0Pu = 0, QMaxPu = 1, QMinPu = -1, RPu = 0, RateFlag = false, RefFlag = false, Rrpwr = 100, SNom = 100, Tiq = 0.05, U0Pu = 1, UInj0Pu = 1, UMaxPu = 1.1, UMinPu = 0.9, UPhaseInj0 = 0, VCompFlag = false, VDLIp11 = 0.9, VDLIp12 = 1.1, VDLIp21 = 1.1, VDLIp22 = 1.1, VDLIp31 = 1.11, VDLIp32 = 1.1, VDLIp41 = 1.12, VDLIp42 = 1.1, VDLIq11 = 0.9, VDLIq12 = 1.1, VDLIq21 = 1.1, VDLIq22 = 1.1, VDLIq31 = 1.11, VDLIq32 = 1.1, VDLIq41 = 1.12, VDLIq42 = 1.1, VFlag = true, VFrz = 0.9, VMaxPu = 1.1, VMinPu = 0.9, VRef0Pu = 1, VRef1Pu = 0, XPu = 0.0, brkpt = 1, i0Pu = Complex(1, 0), iInj0Pu = Complex(1, 0), lvpl1 = 1, s0Pu = Complex(1, 0), tFilterGC = 0.01, tFilterPC = 0.01, tFt = 0.01, tFv = 0.01, tG = 1e-9, tLag = 0.01, tP = 0.01, tPord = 1e-9, tRv = 0.01, u0Pu = Complex(1, 0), uInj0Pu = Complex(1, 0), zerox = 0) annotation(
    Placement(visible = true, transformation(origin = {-50, -27}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Dynawo.Electrical.Buses.InfiniteBus bus_IEC(UPhase = 0, UPu = 1.005) annotation(
    Placement(visible = true, transformation(origin = {16, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Dynawo.Electrical.Buses.InfiniteBus bus_WECC(UPhase = 0, UPu = 1.005) annotation(
    Placement(visible = true, transformation(origin = {18, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Dynawo.Electrical.Events.NodeFault fault_WECC(RPu = 0, XPu = 0.2, tBegin = 1, tEnd = 1.15) annotation(
    Placement(visible = true, transformation(origin = {-16, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Dynawo.Electrical.Events.NodeFault fault_IEC(RPu = 0, XPu = 0.2, tBegin = 1, tEnd = 1.15) annotation(
    Placement(visible = true, transformation(origin = {-16, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));

equation
  line_IEC.switchOffSignal1.value = false;
  line_IEC.switchOffSignal2.value = false;
  line_WECC.switchOffSignal1.value = false;
  line_WECC.switchOffSignal2.value = false;
  WECC_WT4B.injector.switchOffSignal1.value = false;
  WECC_WT4B.injector.switchOffSignal2.value = false;
  WECC_WT4B.injector.switchOffSignal3.value = false;

  connect(wT4ACurrentSource.terminal, line_IEC.terminal1) annotation(
    Line(points = {{-30.4, 28}, {-22, 28}}, color = {0, 0, 255}));
  connect(pWTrefPu.y, wT4ACurrentSource.PWTRefPu) annotation(
    Line(points = {{-99.4, 36}, {-81.15, 36}, {-81.15, 31}, {-66.4, 31}}, color = {0, 0, 127}));
  connect(xWTrefPu.y, wT4ACurrentSource.xWTRefPu) annotation(
    Line(points = {{-99.4, 16}, {-80.9, 16}, {-80.9, 25}, {-66.4, 25}}, color = {0, 0, 127}));
  connect(omegaRefPu.y, wT4ACurrentSource.omegaRefPu) annotation(
    Line(points = {{-119.4, 74}, {-75.9, 74}, {-75.9, 18}, {-66.4, 18}}, color = {0, 0, 127}));
  connect(tanPhi.y, wT4ACurrentSource.tanPhi) annotation(
    Line(points = {{-119.4, 54}, {-72.4, 54}, {-72.4, 38}, {-66.4, 38}}, color = {0, 0, 127}));
  connect(WECC_WT4B.terminal, line_WECC.terminal1) annotation(
    Line(points = {{-33, -27}, {-27, -27}, {-27, -26}, {-26, -26}}, color = {0, 0, 255}));
  connect(WECC_WT4B.PRefPu, pWTrefPu.y) annotation(
    Line(points = {{-69, -17}, {-88, -17}, {-88, 36}, {-100, 36}}, color = {0, 0, 127}));
  connect(WECC_WT4B.QRefPu, xWTrefPu.y) annotation(
    Line(points = {{-69, -27}, {-92, -27}, {-92, 16}, {-100, 16}}, color = {0, 0, 127}));
  connect(line_IEC.terminal2, bus_IEC.terminal) annotation(
    Line(points = {{-2, 28}, {16, 28}, {16, 28}, {14, 28}, {14, 28}, {16, 28}, {16, 28}}, color = {0, 0, 255}));
  connect(line_WECC.terminal2, bus_WECC.terminal) annotation(
    Line(points = {{-4, -26}, {18, -26}, {18, -26}, {16, -26}, {16, -26}, {18, -26}, {18, -26}}, color = {0, 0, 255}));
  connect(fault_WECC.terminal, WECC_WT4B.terminal) annotation(
    Line(points = {{-16, -66}, {-14, -66}, {-14, -40}, {-30, -40}, {-30, -26}, {-32, -26}}, color = {0, 0, 255}));
  connect(fault_IEC.terminal, wT4ACurrentSource.terminal) annotation(
    Line(points = {{-16, 8}, {-16, 22}, {-28, 22}, {-28, 28}, {-30, 28}}, color = {0, 0, 255}));
  annotation(
    uses(Dynawo(version = "1.0.1"), Modelica(version = "3.2.3")),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.001),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    version = "");
end T5_b;