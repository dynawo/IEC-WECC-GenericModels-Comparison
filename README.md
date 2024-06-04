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

The test cases are based upon the V1.5.0 Modelica library of Dynawo, that is available on the Dynawo website, and they have been run using the version 1.18 of [OpenModelica](https://openmodelica.org/).

In order to be able to use the test cases, please then start by downloading the OpenModelica software (V1.18 available [here](https://build.openmodelica.org/omc/builds/windows/releases/1.18/final/64bit/)) and the Dynawo Modelica library V1.5.0 release (available [here](https://github.com/dynawo/dynawo/releases/download/v1.5.0/Dynawo_Modelica_Library_v1.5.0.zip)). Then just clone this github repository to retrieve the Modelica files to redo the test or to look to the models.
Once this is done, just open OpenModelica and import both the Dynawo library (using the package.mo file) and the Modelica library contained in this repository. You are now able to launch the calculations and to play with the cases and model.

## Important remarks and future directions

Please keep in mind that the Modelica code used has been developed and tested using OpenModelica V1.18.
When using more recent versions of OpenModelica, some adjustments could be needed.

At the moment, small modifications compared to the model available in the official Dynawo library are needed to fully represent the WECC A versions, and adjustments regarding the anti-windup structure have been done. The modified models are available in the AdditionalModels directory of the library. In the long term parts of the modifications will be reintegrated in the offical Dynawo library.

In the long term, it is foreseen to add:

1. Large test cases showing the behaviors of both models on large-scale studies, with focus on their differences.
1. Extension of the comparison towards more recent versions of the WECC standards
1. Extension of the comparison to the whole installation (including the plant controller)
