function ret=cast(self,newclass,options)
%CAST	Cast a DNT to a different data type or class
%	ret=CAST(self,newclass) converts underlying type of self to newclass
%	ret=CAST(self,*,like) converts self to the same class, underlying type,
%	field and sparsity as like.
%
%	See also cast, DNT, DNT/underlyingType, DNT/typecast

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		newclass(1,1)string=missing
		options.like
	end
	arguments(Output)
		ret
	end
	dstar=dstarclass;
	zsc.assert(nargin<2||isempty(fieldnames(options)),message("MATLAB:maxrhs"))
	if nargin<=1&&isempty(fieldnames(options))
		error(message("MATLAB:minrhs"))
	end
	if nargin==2
		ret=feval(@cast,self,AdditionalInput={newclass});
	else
		if isa(options.like,"DNT")
			ret=feval(@cast,self,AdditionalInput={gather(options.like)});
		else
			ret=cast(gather(self),dstar{options});
		end
	end
end