# DelphiChangeColorPNG
Change a specific color to another color inside a PNG file (in Delphi)


### Usage

    var
      Apng	  : TPNGImage;
      Acv, Acn : array of TColor;
    begin
    
      Acv    := [clBlack, clRed];
      Acn    := [clWhite, clBlue];
      Apng := TImageToTPngImage(Image1);
    
      MultipleColorChangePNG(Apng, Acv, Acn);
    
      Image1.Picture.Graphic := Apng;
      Apng := nil;
