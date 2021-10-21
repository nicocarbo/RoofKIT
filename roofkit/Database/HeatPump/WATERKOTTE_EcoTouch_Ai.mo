within RoofKIT.Database.HeatPump;
record WATERKOTTE_EcoTouch_Ai = 
  Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic(
    dpHeaSou_nominal = 33530, 
    dpHeaLoa_nominal = 32460, 
    hea(
      TRefLoa = 16 + 273.15, 
      TRefSou = 10 + 273.15, 
      Q_flow = 3533.9, 
      P = 449.1, 
      mSou_flow = 0.1777, 
      mLoa_flow = 0.1278, 
      coeQ = {-6.0831, -0.3793, 7.4731, 0.00, 0.00}, 
      coeP = {-7.7150, 7.0296, 1.6481, 0.00, 0.00}), 
    coo(
      TRefSou = 28 + 273.15, 
      TRefLoa = 12 + 273.15, 
      Q_flow = -55680.00, 
      P = 14244.44, 
      coeQ = {0, 0, 0, 0.0, 0.0}, 
      coeP = {0, 0, 0, 0.0, 0.0})) annotation(
    Documentation(info = "<html>
      <p>
      Company: Waterkotte <br/>
      <br/>
      Modell: EEcoTouch Ai Compact Inverter Geo<br/>
      <br/>
      Base: characteristic curve from measuring over a period of 370 days<br/>
      Note: Only heating is described.
      <li>
      August 19, 2021 by Moritz Bühler:<br/>
      First implementation.
      </li>
      </p>
      </html>"),
      defaultComponentName = "per",
      defaultComponentPrefixes = "parameter" 
      );
