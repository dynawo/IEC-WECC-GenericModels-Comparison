within WindStandardModels.AdditionalModels.WECC;

model LowVoltageIpManagement

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

  parameter Real lvpnt0 "Min low voltage active current breakpoint";
  parameter Real lvpnt1 "Max low voltage active current breakpoint";

  Modelica.Blocks.Interfaces.RealInput Ip_in annotation(
    Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vt annotation(
    Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Ip_out annotation(
    Placement(visible = true, transformation(origin = {117, -1}, extent = {{-17, -17}, {17, 17}}, rotation = 0), iconTransformation(origin = {120, 0}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  Real idlv;
  
equation
  
  Ip_out = Ip_in*idlv;
  idlv = if Vt < lvpnt0 then 0 else if Vt > lvpnt1 then 1 else 1/(lvpnt1-lvpnt0)*(Vt-lvpnt0);

annotation(
    Icon(graphics = {Text(origin = {2, 3}, extent = {{56, -37}, {-56, 37}}, textString = "LV Ip"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end LowVoltageIpManagement;