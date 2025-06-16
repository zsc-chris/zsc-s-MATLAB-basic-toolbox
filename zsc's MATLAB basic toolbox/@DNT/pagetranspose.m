function ret=pagetranspose(self,finalize)
%PAGETRANSPOSE	Page-wise transpose on each page of DNT
%	ret=PAGETRANSPOSE(self,finalize) is the same as
%	ret=transpose(self,[1,2],finalize)
%
%	See also DNT/transpose, pagetranspose, DNT
	arguments(Input)
		self DNT
		finalize(1,1)logical=true
	end
	arguments(Output)
		ret
	end
	ret=transpose(self,[1,2],finalize);
end