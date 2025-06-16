function ret=paddata(self,m,options)
%PADDATA	Pad data for DNT
%	ret=PADDATA(self,m,*,Dimension=1:numel(m),Fillvalue=.../Pattern=...,Side="trailing") pads self to size m along Dimension.
%
%	Example:
%	>> PADDATA(DNT,3,Dimension=["a","b"],Fillvalue=nan)
%
%	ans =
%
%	  3×3 DNT double matrix
%
%	         b           1      2      3
%	    a
%
%	    1                0    NaN    NaN
%	    2              NaN    NaN    NaN
%	    3              NaN    NaN    NaN
%
%	>> PADDATA(DNT(1:5,"a"),5,Dimension="b",Pattern="circular")
%
%	ans =
%
%	  5×5 DNT double matrix
%
%	         b         1    2    3    4    5
%	    a
%
%	    1              1    1    1    1    1
%	    2              2    2    2    2    2
%	    3              3    3    3    3    3
%	    4              4    4    4    4    4
%	    5              5    5    5    5    5
%
%	>> PADDATA(DNT([],"a"),5,Dimension="b")
%
%	ans =
%
%	  0×5 empty DNT double matrix with properties:
%
%	    dimnames: ["a"    "b"]
%
%	See also paddata, DNT

%	Copyright 2025 Chris H. Zhao
	arguments
		self DNT
		m(1,:)double{mustBeInteger,mustBeNonnegative}
		options.Dimension(1,:){mustBeA(options.Dimension,["logical","numeric","string","char","cell","missing","missing"])}=1:numel(m)
		options.Fillvalue(1,1)
		options.Pattern(1,1)string{mustBeMember(options.Pattern,["constant","edge","circular","flip","reflect"])}
		options.Side(1,1)string{mustBeMember(options.Side,["trailing","leading","both"])}="trailing"
	end
	dstar=dstarclass;
	zsc.assert(~all(isfield(options,["FillValue","Pattern"])),message("MATLAB:resize:PatternAndFillValue"))
	ret=fevalalong(@(x,dim,varargin)zsc.paddata(x,m,varargin{:},Dimension=dim),options.Dimension,self,KeepDims=true,AdditionalInput={dstar{rmfield(options,"Dimension")}});
end