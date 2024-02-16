# Install ANSYS-2021-R1 or higher version.
# Install ansys-mapdl-core: python -m pip install ansys-mapdl-core -i https://pypi.tuna.tsinghua.edu.cn/simple 
from ansys.mapdl import reader as pymapdl_reader

result = pymapdl_reader.read_binary('file.rst')
print(result)

# result.save_as_vtk('file.vtu', [0])
result.save_as_vtk('ansys_vtk_file.vtk', [0])