unit uChangeColorPNG;

//========================================================================================================================================================================//
//                                                                                                                                                                        //
// BASED ON: https://web.archive.org/web/20160723193549/http://stackoverflow.com/questions/20665659/how-can-i-change-color-from-a-png-image-from-white-to-black-in-delphi //
//                                                                                                                                                                        //
// (But simplyfied by me - Mr. Glasses)                                                                                                                                  //
//                                                                                                                                                                        //
// Simple color changer, no much more than that                                                                                                                           //
//                                                                                                                                                                        //
//                                                                                                                                                                        //
//========================================================================================================================================================================//


interface

uses
  Vcl.Graphics, PNGImage, Vcl.ExtCtrls, Windows, SysUtils;


  function TImageToTPngImage(Aimg: TImage): TPNGImage; //THE ORIGINAL FILE MUST BE A PNG
  procedure SimpleChangePNGColor(Aimg: TPngImage; AoldColor, AnewColor: TColor); //change a specific color in a PNG image
  procedure MultipleColorChangePNG(Aimg: TPngImage; AoldColors, AnewColors: array of TColor); //change a group of colors to another group of colors
implementation

function TImageToTPngImage(Aimg: TImage): TPNGImage; //THE ORIGINAL FILE MUST BE A PNG
begin
  Result := TPNGImage(Aimg.Picture.Graphic);
end;

procedure SimpleChangePNGColor(Aimg: TPngImage; AoldColor, AnewColor: TColor); //change a specific color in a PNG image
var
  x, y       : Integer;
  line       : PRGBLine;
  actualColor: TColor;
begin
  for y := 0 to Aimg.Height - 1 do
  begin
    line := Aimg.Scanline[Y];
    for x := 0 to Aimg.Width - 1 do
    begin
      actualColor := RGB(line[X].rgbtRed, line[X].rgbtGreen, line[X].rgbtBlue);
      if actualColor = AoldColor then
      begin
        line[x].rgbtRed   := GetRValue(ColorToRGB(AnewColor));
        line[x].rgbtGreen := GetGValue(ColorToRGB(AnewColor));
        line[x].rgbtBlue  := GetBValue(ColorToRGB(AnewColor));
      end;
    end;
  end;
end;

procedure MultipleColorChangePNG(Aimg: TPngImage; AoldColors, AnewColors: array of TColor); //change a group of colors to another group of colors
  function PosColor(Acolor: TColor; Acolors: Array of TColor): Integer;                      //BE CAREFUL WITH CONFLICTING COLORS (aka same color on both sides)
  var
    i: Integer;
  begin
    Result := -1;

    for i := Low(Acolors) to High(Acolors) do
    begin
      if Acolor = Acolors[i] then
      begin
        Result := i;
        break;
      end;
    end;
  end;
var
  x, y       : Integer;
  line       : PRGBLine;
  actualColor: TColor;
  index      : Integer;
begin
  if Length(AoldColors) <> Length(AnewColors) then
    raise Exception.Create('Color arrays with different sizes!');

  for y := 0 to Aimg.Height - 1 do
  begin
    line := Aimg.Scanline[Y];
    for x := 0 to Aimg.Width - 1 do
    begin
      actualColor := RGB(line[X].rgbtRed, line[X].rgbtGreen, line[X].rgbtBlue);
      index := PosColor(actualColor, AoldColors);
      if index <> -1 then
      begin
        line[x].rgbtRed   := GetRValue(ColorToRGB(AnewColors[index]));
        line[x].rgbtGreen := GetGValue(ColorToRGB(AnewColors[index]));
        line[x].rgbtBlue  := GetBValue(ColorToRGB(AnewColors[index]));
      end;
    end;
  end;
end;

end.
