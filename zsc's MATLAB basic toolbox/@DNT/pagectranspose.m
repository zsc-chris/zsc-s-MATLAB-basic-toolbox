function ret=pagectranspose(self,finalize)
%PAGECTRANSPOSE	Page-wise transpose on each page of DNT
%	ret=PAGECTRANSPOSE(self,finalize) is the same as
%	ret=ctranspose(self,[1,2],finalize)
%
%	See DNT/ctranspose, pagectranspose, DNT
	arguments(Input)
		self DNT
		finalize(1,1)logical=true
	end
	arguments(Output)
		ret
	end
	ret=ctranspose(self,[1,2],finalize);
end