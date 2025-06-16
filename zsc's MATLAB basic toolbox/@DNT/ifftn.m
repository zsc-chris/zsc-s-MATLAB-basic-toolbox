function ret=ifftn(self,sz,symflag)
%IFFTN	N-dimensional inverse discrete Fourier Transform
%	ret=ifftn(self,sz=size(self),symflag="nonsymmetric")
%
%	See also ifftn, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		sz(1,:)double{mustBeInteger,mustBeNonnegative}=size(self)
		symflag(1,1)string{mustBeMember(symflag,["symmetric","nonsymmetric"])}="nonsymmetric"
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@ifftn,self,AdditionalInput={sz,symflag});
end