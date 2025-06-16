function ret=trimdata(self,m,options)
%TRIMDATA	Trim data for DNT
%	ret=TRIMDATA(self,m,*,Dimension=1:numel(m),Side="trailing") trims self to size m along Dimension.
%
%	Example:
%	>> TRIMDATA(DNT([1,2;3,4],["a","b"]),[1,0])
%
%	ans =
%
%	  1×0 empty DNT double matrix with properties:
%
%	    dimnames: ["a"    "b"]
%
%	See also trimdata, DNT

%	Copyright 2025 Chris H. Zhao
	arguments
		self DNT
		m(1,:)double{mustBeInteger,mustBeNonnegative}
		options.Dimension(1,:){mustBeA(options.Dimension,["logical","numeric","string","char","cell","missing","missing"])}=1:numel(m)
		options.Side(1,1)string{mustBeMember(options.Side,["trailing","leading","both"])}="trailing"
	end
	dstar=dstarclass;
	ret=fevalalong(@(x,dim,varargin)zsc.trimdata(x,m,varargin{:},Dimension=dim),options.Dimension,self,KeepDims=true,AdditionalInput={dstar{rmfield(options,"Dimension")}});
end