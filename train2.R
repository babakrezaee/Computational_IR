
##################################################################
### 1) PREPARING THE ENVIRONMENT AND READING THE NETWORK DATA: ###
##################################################################


rm(list = ls())

# Load the igraph library
library(igraph)


# Read the data while skipping the first three lines (metadata)
# Read the data while skipping the first three lines (metadata)
file_path <- "https://raw.githubusercontent.com/babakrezaee/MethodsCourses/refs/heads/master/DataSets/train_edgelist.txt"  # Adjust the path

edges <- read.table(file_path)

# Convert the data to a graph
g <- graph_from_data_frame(edges, directed = FALSE)

# Set a fixed seed for reproducibility
set.seed(1234)


################################################################################

#######################################################################
### 2) ATTACKING THE NETWORK BASED ON RANDOM SELECTION OF 20 NODES: ###
#######################################################################


n <- 20  

# Randomly select n nodes
set.seed(12345)
nodes_to_remove <- sample(V(g), n)

# Remove selected nodes and their edges
g_reduced <- delete_vertices(g, nodes_to_remove)

# Generate a new fixed layout for visualization
layout_reduced <- layout_with_fr(g_reduced)

# Plot the resulting graph after random node removal
plot(g_reduced, 
     layout = layout_reduced,  # Use the new layout
     vertex.size = 5,  # Increase node size
     vertex.color = "deepskyblue",  # Color nodes blue
     vertex.label = V(g_reduced)$name,  # Display node IDs
     vertex.label.cex = 1,  # Adjust label size
     vertex.label.color = "black",  # Ensure labels are readable
     edge.width = 1,  # Use standard edge width
     rescale = TRUE,  # Ensure layout scales properly
     asp = 0)  # Allow flexible aspect ratio


# Compute the size of the largest connected component:
comp <- components(g_reduced) 
largest_component_size <- max(comp$csize)
print(paste("The size of the largest component is:", largest_component_size))


################################################################################

####################################################################
### 3) ATTACKING THE NETWORK BASED ON THE 20 MOST CENTRAL NODES: ###
####################################################################


# Choose the centrality measure (Change this as needed):

centrality_measure <- degree(g, mode = "all")
# centrality_measure <- eigen_centrality(g, directed = FALSE)$vector
# centrality_measure <- betweenness(g, directed = FALSE, normalized = TRUE)
# centrality_measure <- closeness(g, normalized = TRUE)


# Sort nodes by centrality in descending order
sorted_nodes <- order(centrality_measure, decreasing = TRUE)

# Number of nodes to remove (Change this value)
n <- 20

# Select the top n nodes with highest centrality
nodes_to_remove <- V(g)[sorted_nodes[1:n]]

# Remove selected nodes and their edges
g_reduced <- delete_vertices(g, nodes_to_remove)

# Generate a new fixed layout for visualization
layout_reduced <- layout_with_fr(g_reduced)

# Plot the resulting graph after node removal
plot(g_reduced,
     layout = layout_reduced,  # Use the new layout
     vertex.size = 5,  # Increase node size
     vertex.color = "deepskyblue",  # Color nodes blue
     vertex.label = V(g_reduced)$name,  # Display node IDs
     vertex.label.cex = 1,  # Adjust label size
     vertex.label.color = "black",  # Ensure labels are readable
     edge.width = 1,  # Use standard edge width
     rescale = TRUE,  # Ensure layout scales properly
     asp = 0)  # Allow flexible aspect ratio


# Compute the size of the largest connected component:
comp <- components(g_reduced) 
largest_component_size <- max(comp$csize)
print(paste("The size of the largest component is:", largest_component_size))
