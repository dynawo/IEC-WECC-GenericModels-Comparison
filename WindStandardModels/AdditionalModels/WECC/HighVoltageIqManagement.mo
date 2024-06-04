within WindStandardModels.AdditionalModels.WECC;

model HighVoltageIqManagement

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

  parameter Real Volim(start=1.5) "Voltage limit for high voltage clamp logic in p. u.";
  parameter Real Iolim(start=1.5) "Current limit for high voltage clamp logic in p. u.";
  parameter Real Khv(start=1.0) "High voltage clamp logic accelerator factor";

  Modelica.Blocks.Interfaces.RealOutput Iq_out annotation(
    Placement(visible = true, transformation(origin = {117, -1}, extent = {{-17, -17}, {17, 17}}, rotation = 0), iconTransformation(origin = {120, 0}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vt annotation(
    Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Iq_in annotation(
    Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Real iqhv;
  
equation
  
  Iq_out = max(Iq_in - iqhv, Iolim);
  iqhv = if Vt > Volim then Khv*(Vt-Volim) else 0;
annotation(
    Icon(graphics = {Text(origin = {6, 3}, extent = {{70, -31}, {-70, 31}}, textString = "HV Iq"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end HighVoltageIqManagement;