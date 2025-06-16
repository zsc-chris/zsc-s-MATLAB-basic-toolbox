function DNTs=applyalong(self,f,dims,options)
%APPLYALONG	Eval a function on a DNT along certain dimensions
%	*DNTs=APPLYALONG(self,f,dims=self.dimnames,**options) is the same as
%	*DNTs=fevalalong(self,f,dims=self.dimnames,**options).
%
%	See also DNT/fevalalong

%	Copyright 2024–2025 Chris H. Zhao
	arguments(Input)
		self DNT
		f(1,1)function_handle
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		options.Mode(1,1)string{mustBeMember(options.Mode,["direct","flatten","iterate"])}
		options.KeepDims(1,:)logical=false
		options.Unflatten(1,:)double{mustBeInteger,mustBeNonnegative}=0
		options.KeepOtherDims(1,:)logical=false
		options.UnflattenOther(1,:)double{mustBeInteger,mustBeNonnegative}=0
		options.Vectorized(1,1)logical
		options.AdditionalInput(1,:)cell
	end
	arguments(Output,Repeating)
		DNTs DNT
	end
	dstar=dstarclass;
	[DNTs{1:nargout}]=fevalalong(f,dims,self,dstar{options});
end