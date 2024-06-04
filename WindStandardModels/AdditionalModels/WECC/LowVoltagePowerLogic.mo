within WindStandardModels.AdditionalModels.WECC;

model LowVoltagePowerLogic
  
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
  
  parameter Real zerox(start=0.0) "LVPL zero crossing in pu";
  parameter Real brkpt(start=1.0) "LVPL breakpoint in pu";
  parameter Real lvpl1(start=1.0) "LVPL gain breakpoint in pu";
  
  Modelica.Blocks.Interfaces.RealOutput LVPL annotation(
    Placement(visible = true, transformation(origin = {117, -1}, extent = {{-17, -17}, {17, 17}}, rotation = 0), iconTransformation(origin = {120, 0}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput UPu annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Real mlvpl;

equation
  LVPL = if UPu < zerox then 0 else if UPu > brkpt then 9999 else mlvpl*(UPu - zerox);
  mlvpl = lvpl1/(brkpt-zerox);
  
annotation(
    Icon(graphics = {Text(origin = {4, 4}, extent = {{-54, 40}, {54, -40}}, textString = "LVPL"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end LowVoltagePowerLogic;