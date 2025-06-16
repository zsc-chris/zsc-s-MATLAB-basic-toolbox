function ret=kron(self,other)
%KRON	Kronecker tensor product
%	ret=KRON(self,other)
%
%	See also kron, DNT

%	Chris H. Zhao
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@zsc.kron,self,other,BroadcastSize=false);
end