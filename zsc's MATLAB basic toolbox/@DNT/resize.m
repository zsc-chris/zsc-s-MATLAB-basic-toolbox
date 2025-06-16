function ret=resize(self,m,options)
%RESIZE	Resize data by adding or removing elements for DNT
%	ret=RESIZE(self,m,*,Dimension=1:numel(m),Fillvalue=.../Pattern=...,Side="trailing") resizes self to size m along Dimension.
%
%	Example:
%	>> RESIZE(DNT([1,2;3,4],["a","b"]),[1,3],Fillvalue=nan)
%
%	ans =
%
%	  1×3 DNT double matrix
%
%	         b           1      2      3
%	    a
%
%	    1                1      2    NaN
%
%	>> RESIZE(DNT(1:5,"a"),5,Dimension="b",Pattern="circular")
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
%	See also resize, DNT

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
	ret=fevalalong(@(x,dim,varargin)zsc.resize(x,m,varargin{:},Dimension=dim),options.Dimension,self,KeepDims=true,AdditionalInput={dstar{rmfield(options,"Dimension")}});
end