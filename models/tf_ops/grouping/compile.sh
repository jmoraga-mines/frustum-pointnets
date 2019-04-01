g++ query_ball_point.cpp -o query_ball_point -I /usr/local/cuda/include -L /usr/local/cuda/lib64
nvcc query_ball_point.cu -o query_ball_point_cuda -I /usr/local/cuda/include -L /usr/local/cuda/lib64
nvcc query_ball_point_block.cu -o query_ball_point_block -I /usr/local/cuda/include -L /usr/local/cuda/lib64
nvcc query_ball_point_grid.cu -o query_ball_point_grid -I /usr/local/cuda/include -L /usr/local/cuda/lib64
nvcc query_ball_point_grid_count.cu -o query_ball_point_grid_count -I /usr/local/cuda/include -L /usr/local/cuda/lib64
g++ -Wall selection_sort.cpp -o selection_sort -I /usr/local/cuda/include -L /usr/local/cuda/lib64
nvcc selection_sort.cu -o selection_sort_cuda -I /usr/local/cuda/include -L /usr/local/cuda/lib64
