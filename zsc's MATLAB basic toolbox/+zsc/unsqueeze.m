function B=unsqueeze(B,dims)
%zsc.unsqueeze	Inverse of zsc.squeeze
%	A=zsc.unsqueeze(B,dims) returns B so that zsc.squeeze(A,dims)=B.
%
%	See also zsc.squeeze

%	Copyright 2025 Chris H. Zhao
	arguments
		B
		dims(1,:)double{mustBeInteger,mustBePositive}=[]
	end
	dims=unique(dims);
	sz=nan(1,ndims(B)+max(dims));
	sz(dims)=1;
	sz(find(isnan(sz),ndims(B)))=size(B);
	sz(isnan(sz))=1;
	B=reshape(B,paddata(sz,[1,2],FillValue=1));
end