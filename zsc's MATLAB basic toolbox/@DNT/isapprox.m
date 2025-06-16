function ret=isapprox(self,other,tol,options)
%ISAPPROX	Determine approximate equality for DNT
%	ret=ISAPPROX(self,
%	other[,tol/,*[,RelativeTolerance][,AbsoluteTolerance]])
%
%	See also isapprox, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		other DNT
		tol(1,1)string{mustBeMember(tol,["verytight","tight","loose","veryloose"])}="verytight"
		options.RelativeTolerance(1,1)double{mustBeInRange(options.RelativeTolerance,0,1,"exclude-upper")}
		options.AbsoluteTolerance(1,1)double{mustBeNonnegative}
	end
	arguments(Output)
		ret DNT
	end
	dstar=dstarclass;
	zsc.assert(nargin<3||isempty(fieldnames(options)),message("MATLAB:isapprox:LevelWithOtherOption"))
	if nargin==3
		ret=feval(@isapprox,self,other,AdditionalInput={tol});
	else
		ret=feval(@isapprox,self,other,AdditionalInput={dstar{options}});
	end
end