echo on
for /l %%x in (1, 1, 1000) do (
   echo %%x
   cucumber -t@criarClienteCompraLojaClone
)