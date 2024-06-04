within WindStandardModels.AdditionalModels.WECC;

record Parameters_mod "Parameters of the PV WECC model"
  extends Modelica.Icons.RecordsPackage;

  record Params_PlantControl
    parameter Boolean RefFlag "Plant level reactive power (0) or voltage control (1)" annotation(Dialog(tab="Plant Control"));
    parameter Boolean VCompFlag "Reactive droop (0) or line drop compensation (1) if RefFlag true" annotation(Dialog(tab="Plant Control"));
    parameter Boolean FreqFlag "Governor response disable (0) or enable (1)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit Kc "Reactive droop when VCompFlag = 0" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.Time tFilterPC "Voltage and reactive power filter time constant in s (typical: 0.01..0.02)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit Dbd "Reactive power deadband when RefFlag = 0; Voltage deadband when RefFlag = 1" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit EMax "Maximum Volt/VAR error" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit EMin "Minimum Volt/VAR error" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit QMaxPu "Maximum plant level reactive power command in pu (base SNom)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit QMinPu "Minimum plant level reactive power command in pu (base SNom)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.Time tFt "Plant controller Q output lead time constant in s" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.Time tFv "Plant controller Q output lag time constant in s (typical: 0.15..5)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.Time tP "Active power filter time constant in s (typical: 0.01..0.02)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit FDbd1 "Overfrequency deadband for governor response (typical: 0.004)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit FDbd2 "Underfrequency deadband for governor response (typical: 0.004)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit DDn "Down regulation droop (typical: 20..33.3)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit DUp "Up regulation droop (typical: 0)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit FEMax "Maximum power error in droop regulator" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit FEMin "Minimum power error in droop regulator" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit PMaxPu "Maximum plant level active power command in pu (base SNom)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit PMinPu "Minimum plant level active power command in pu (base SNom)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.Time tLag "Plant controller P output lag time constant in s(typical: 0.15..5)" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit Kp "Volt/VAR regulator proportional gain" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit Ki "Volt/VAR regulator integral gain" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit Kpg "Droop regulator proportional gain" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit Kig "Droop regulator integral gain" annotation(Dialog(tab="Plant Control"));
    parameter Dynawo.Types.PerUnit VFrz "Voltage for freezing Volt/VAR regulator integrator (typical: 0..0.9)" annotation(Dialog(tab="Plant Control"));
  annotation(preferredView = "text");
  end Params_PlantControl;

  record Params_ElectricalControl
    parameter Boolean QFlag "Q control flag: const. pf or Q ctrl (0) or voltage/Q (1)" annotation(Dialog(tab="Electrical Control"));
    parameter Boolean VFlag "Voltage control flag: voltage control (0) or Q ctrl (1)" annotation(Dialog(tab="Electrical Control"));
    parameter Boolean PfFlag "Power factor flag: Q control (0) or pf control(1)" annotation(Dialog(tab="Electrical Control"));
    parameter Boolean PPriority "Q/P priority: Q priority (0) or P priority (1)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.Time tRv "Filter time constant terminal voltage in s(typical: 0.01..0.02)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit UMinPu "Low voltage condition trigger voltage for FRT in pu (base UNom) (typical: 0..0.9)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit UMaxPu "High voltage condition trigger voltage for FRT in pu (base UNom) (typical: 1.1..1.3)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit VRef0Pu "Reference voltage for reactive current injection in pu (base UNom) (typical: 0.95..1.05)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit Dbd1 "Overvoltage deadband for reactive current injection (typical: -0.1..0)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit Dbd2 "Undervoltage deadband for reactive current injection (typical: 0..0.1)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit Kqv "K-Factor, reactive current injection gain (typical: 0..10)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit Iqh1Pu "Maximum reactive current injection (typical: 1..1.1) in pu (base UNom, SNom)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit Iql1Pu "Minimum reactive current injection (typical: -1.1..-1) in pu (base UNom, SNom)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.Time tP "Filter time constant active power in s (typical: 0.1..0.2)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit QMaxPu "Reactive power upper limit, when vFlag == 1 in pu (base SNom)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit QMinPu "Reactive power lower limit, when vFlag == 1 in pu (base SNom)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit Kqp "Proportional gain local reactive power PI controller" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit Kqi "Integrator gain local reactive power PI controller" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit VMaxPu "Maximum voltage at inverter terminal in pu (base UNom) (typical: 1.05..1.15)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit VMinPu "Minimum voltage at inverter terminal in pu (base UNom) (typical: 0.85..0.95)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit Kvp "Proportional gain local Voltage PI controller" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit Kvi "Integrator gain local Voltage PI controller" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.Time Tiq "Filter time constant reactive current in s(typical: 0.01..0.02)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.Time tPord "Filter time constant inverter active power in s" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit PMaxPu "Active power upper limit in pu (base SNom) (typical: 1)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit PMinPu "Active power lower limit in pu (base SNom) (typical: 0)" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit DPMax "Active power upper rate limit" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit DPMin "Active power lower rate limit" annotation(Dialog(tab="Electrical Control"));
    parameter Dynawo.Types.PerUnit IMaxPu "Maximal apparent current magnitude in pu (base UNom, SNom)" annotation(Dialog(tab="Electrical Control"));
    
    parameter Dynawo.Types.PerUnit Ni(start=20) "Gains of PI Controller anti-windup paths (set to 0 to disable anti-windup)" annotation(Dialog(tab="Electrical Control"));
  
    
    parameter Dynawo.Types.ActivePowerPu PInj0Pu "Start value of active power at injector terminal in pu (generator convention) (base SNom)";
    parameter Dynawo.Types.ReactivePowerPu QInj0Pu "Start value of reactive power at injector terminal in pu (generator convention) (base SNom)";
    parameter Dynawo.Types.VoltageModulePu UInj0Pu "Start value of voltage magnitude at injector terminal in pu (base UNom)";
    parameter Dynawo.Types.PerUnit PF0 "Start value of powerfactor";
    parameter Dynawo.Types.CurrentModulePu Id0Pu "Start value of d-component current at injector terminal in pu (generator convention) (base SNom, UNom)";
    parameter Dynawo.Types.CurrentModulePu Iq0Pu "Start value of q-component current at injector terminal in pu (generator convention) (base SNom, UNom)";
  annotation(preferredView = "text");
  end Params_ElectricalControl;

  record Params_GeneratorControl
    parameter Dynawo.Types.Time tG "Emulated delay in converter controls in s(Cannot be zero, typical: 0.02..0.05)" annotation(Dialog(tab="Generator Control"));
    parameter Dynawo.Types.Time tFilterGC "Filter time constant of terminal voltage in s(Cannot be set to zero, typical: 0.02..0.05)" annotation(Dialog(tab="Generator Control"));
    parameter Dynawo.Types.PerUnit IqrMinPu "Minimum rate-of-change of reactive current after fault in pu (base UNom, SNom) (typical: -999..-1)" annotation(Dialog(tab="Generator Control"));
    parameter Dynawo.Types.PerUnit IqrMaxPu "Maximum rate-of-change of reactive current after fault in pu (base UNom, SNom) (typical: 1..999)" annotation(Dialog(tab="Generator Control"));
    parameter Dynawo.Types.PerUnit Rrpwr "Active power recovery time [pu/s] (typical: 1..20)" annotation(Dialog(tab="Generator Control"));
    parameter Boolean RateFlag "Active current (=false) or active power (=true) ramp (if unkown set to false)" annotation(Dialog(tab="Generator Control"));
    parameter Boolean Lvplsw(start=false) "Low voltage power logic switch: 1-enabled/0-disabled" annotation(Dialog(tab="Generator Control"));
    parameter Real zerox(start=0.0) "LVPL zero crossing in pu" annotation(Dialog(tab="Generator Control"));
    parameter Real brkpt(start=1.0) "LVPL breakpoint in pu" annotation(Dialog(tab="Generator Control"));
    parameter Real lvpl1(start=1.0) "LVPL gain breakpoint in pu" annotation(Dialog(tab="Generator Control"));
  annotation(preferredView = "text");
  end Params_GeneratorControl;

  record Params_PLL
    parameter Dynawo.Types.PerUnit KpPLL "PLL proportional gain" annotation(Dialog(tab="PLL"));
    parameter Dynawo.Types.PerUnit KiPLL "PLL integrator gain" annotation(Dialog(tab="PLL"));
    parameter Dynawo.Types.PerUnit OmegaMinPu "Lower frequency limit in pu" annotation(Dialog(tab="PLL"));
    parameter Dynawo.Types.PerUnit OmegaMaxPu "Upper frequency limit in pu" annotation(Dialog(tab="PLL"));
  annotation(preferredView = "text");
  end Params_PLL;

  record Params_VSourceRef
    parameter Dynawo.Types.Time tE "Emulated delay in converter controls in s (cannot be zero, typical: 0.02..0.05)";
    parameter Dynawo.Types.PerUnit RSourcePu "Source resistance in pu (base UNom, SNom)";
    parameter Dynawo.Types.PerUnit XSourcePu "Source reactance in pu (base UNom, SNom)";
  annotation(preferredView = "text");
  end Params_VSourceRef;

  record Params_DriveTrain
    parameter Dynawo.Types.Time Ht "Turbine Inertia in s (typical: 5s)";
    parameter Dynawo.Types.Time Hg "Generator Inertia in s (typical: 1s)";
    parameter Dynawo.Types.PerUnit Dshaft "Damping coefficient in pu (typical: 1.5 pu, base SNom, omegaNom)";
    parameter Dynawo.Types.PerUnit Kshaft "Spring constant in pu (typical: 200 pu, base SNom, omegaNom)";
  end Params_DriveTrain;

end Parameters_mod;
