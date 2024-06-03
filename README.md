# Content
This github repository contains the models and use cases utilized for the comparison of WT Type 4 generic models (WECC and IEC Ed. 2020 models).
They correspond to the work described in the following paper "Comparing IEC and WECC Generic Dynamic Models for Type 4 Wind Turbines", M. Franke, A. Guironnet and C. Cardozo, published in the proceedings of PSCC 2024 and in the associated extended report.

## Test cases description

The repository currently contains the following test cases enabling to show the equivalences between both models and to highlight their structural differences:

### Equivalent behaviors

| Name | Description |
| ---- | ------------|
| T1 | Active power step at t = 1 s |
| T2 | Reactive power step at t = 1 s|
| T3 | Voltage set point change at t = 1 s|
| T4 | Solid short-circuit fault from t = 1 to t = 1.15 s |

### Different behaviors

| Name | Description | Difference |
| ---- | ------------| ----------- |
| T3_b | Larger voltage set point change at t = 1 s | WT_CLS active/reactive power priority outside FRT |
| T3_c | Voltage set point change at t = 1 s| Highlight the influence of the Kpqu-logic |
| T4_b | Solid short-circuit fault from t = 1 to t = 1.15 s with a filtering value for Q in IEC| Highlight the impact of Q measurement filtering |
| T5_a | Short circuit with an impedance from t = 1 to t = 1.15 s with equivalent parameters | Active power dynamic response |
| T5_b | Short circuit with an impedance from t = 1 to t = 1.15 s with adapted parameters | Identical response when dynamics neglegted|
| T6 | Long voltage drop | Impact of the fast injection path calculation |

## Getting started

The test cases are based upon the V1.5.0 Modelica library of Dynawo, that is available on the Dynawo website, and they have been run using the version 1.18 of OpenModelica.
In order to be able to use the test cases, please then do
