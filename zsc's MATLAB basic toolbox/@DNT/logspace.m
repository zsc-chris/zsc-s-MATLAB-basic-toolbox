function ret=logspace(self,other,n,dim,options)
%LOGSPACE	Logspace DNT
%	ret=LOGSPACE(self,other,n=50,dim="x",*,Precise=true) is the same as
%	ret=10.^linspace(self,other,n,dim,Precise=precise)
%
%	Note: Unlike MATLAB logspace, pi is treated as ordinary input.
%
%	See also logspace, DNT, DNT/linspace

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT{mustBeNonempty}
		other DNT{mustBeNonempty}
		n(1,1)double{mustBeInteger,mustBePositive}=50
		dim(1,1)string="x"
	end
	arguments(Input)
		options.Precise=false
	end
	arguments(Output)
		ret DNT
	end
	dstar=dstarclass;
	ret=10.^linspace(self,other,n,dim,dstar{options});
end