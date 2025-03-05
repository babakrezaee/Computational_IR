# Install igraph if you don't already have it:
install.packages("igraph")

##################################################################
### 1) PREPARING THE ENVIRONMENT AND READING THE NETWORK DATA: ###
##################################################################


rm(list = ls())

# Load the igraph library
library(igraph)


# Read the data while skipping the first three lines (metadata)
file_path <- "https://raw.githubusercontent.com/babakrezaee/MethodsCourses/refs/heads/master/DataSets/train_edgelist.txt"  # Adjust the path

edges <- read.table(file_path)

# Convert the data to a graph
g <- graph_from_data_frame(edges, directed = FALSE)

# Set a fixed seed for reproducibility
set.seed(1234)


################################################################################

################################
### 2) PLOTTING THE NETWORK: ###
################################


# Generate a fixed layout
layout_fixed <- layout_with_fr(g)  # Fruchterman-Reingold layout

# Plot the graph
plot(g, 
     layout = layout_fixed,  # Use the precomputed layout
     vertex.size = 5,  # Increase node size
     vertex.color = "deepskyblue",  # Change node color to blue
     vertex.label = V(g)$name,  # Display node IDs
     vertex.label.cex = 1,  # Adjust label size
     vertex.label.color = "black",  # Ensure labels are readable
     edge.width = edges$V3,  # Use edge weights for thickness
     rescale = TRUE,  # Ensure layout scales properly
     asp = 0)  # Allow flexible aspect ratio


################################################################################

#################################################
### 3) GETTING THE NUMBER OF NODES AND EDGES: ###
#################################################


# Get the number of nodes
num_nodes <- vcount(g)

# Print the result
print(paste("The number of nodes in the network is:", num_nodes))



# Get the number of edges
num_edges <- ecount(g)

# Print the result
print(paste("The number of edges in the network is:", num_edges))


################################################################################

##########################################################
### 4) GETTING THE AVERAGE DEGREE AND NETWORK DENSITY: ###
##########################################################


# Get the average degree (rounded to 2 decimal points)
avg_degree <- round(mean(degree(g)),2)
                   
# Print the result
print(paste("The average degree in the network is:", avg_degree))



# Get the network density (rounded to 2 decimal points)
graph_density <- round(edge_density(g),2)

# Print the result
print(paste("The network density is:", graph_density))


g_complete <- make_full_graph(64)

# Plot the graph
plot(g_complete, 
     layout = layout_fixed,  # Use the precomputed layout
     vertex.size = 5,  # Increase node size
     vertex.color = "deepskyblue",  # Change node color to blue
     vertex.label = V(g)$name,  # Display node IDs
     vertex.label.cex = 1,  # Adjust label size
     vertex.label.color = "black",  # Ensure labels are readable
     edge.width = edges$V3,  # Use edge weights for thickness
     rescale = TRUE,  # Ensure layout scales properly
     asp = 0)  # Allow flexible aspect ratio

################################################################################

#####################################################
### 5) VISUALIZING DIFFERENT CENTRALITY MEASURES: ###
#####################################################


# Choose the centrality measure (Change this as needed):

centrality_measure <- degree(g, mode = "all")
# centrality_measure <- eigen_centrality(g, directed = FALSE)$vector
# centrality_measure <- betweenness(g, directed = FALSE, normalized = TRUE)
# centrality_measure <- closeness(g, normalized = TRUE)



# Normalize centrality values to range [0, 1]
normalized_centrality <- (centrality_measure - min(centrality_measure)) / 
  (max(centrality_measure) - min(centrality_measure))

# Define a blue color gradient (light blue to dark blue)
color_palette <- colorRampPalette(c("lightblue", "blue"))

# Assign colors based on centrality
node_colors <- color_palette(100)[as.numeric(cut(normalized_centrality, breaks = 100))]

# Plot the graph with degree-based node colors
plot(g, 
     layout = layout_fixed,  # Use the precomputed layout
     vertex.size = 5,  # Increase node size
     vertex.color = node_colors,  # Color nodes based on centrality
     vertex.label = V(g)$name,  # Display node IDs
     vertex.label.cex = 1,  # Adjust label size
     vertex.label.color = "black",  # Ensure labels are readable
     edge.width = edges$V3,  # Use edge weights for thickness
     rescale = TRUE,  # Ensure layout scales properly
     asp = 0)  # Allow flexible aspect ratio

