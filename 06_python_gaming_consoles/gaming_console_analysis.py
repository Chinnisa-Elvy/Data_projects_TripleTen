"""
Gaming Console Sales Analysis
Analyst: Chinnisa Elvy
Program: TripleTen Business Intelligence Analyst Program

This script analyzes historical sales data for discontinued gaming consoles.
The goal is to evaluate console popularity, lifespan, and estimated revenue
to support pricing and repair prioritization decisions.
"""

# Dataset: historical gaming console data
console_data = [
    ['NES', 'Nintendo', 1985, 1995, 179.0, 61910000],
    ['Game Boy', 'Nintendo', 1989, 2003, 89.99, 118690000],
    ['SNES', 'Nintendo', 1990, 2003, 199.0, 49100000],
    ['Virtual Boy', 'Nintendo', 1995, 1996, 179.95, 770000],
    ['Game Boy Advance', 'Nintendo', 2001, 2010, 99.99, 81510000],
    ['Atari 2600', 'Atari', 1977, 1992, 199.0, 30000000],
    ['Sega Genesis', 'Sega', 1988, 1997, 189.0, 30750000],
    ['Game Gear', 'Sega', 1990, 1997, 149.99, 10620000],
    ['Sega CD', 'Sega', 1991, 1996, 299.0, 2240000],
    ['3DO', 'The 3DO Company', 1993, 1996, 699.99, 2000000],
    ['PlayStation', 'Sony Electronics', 1994, 2006, 299.0, 102490000],
    ['PlayStation 2', 'Sony Electronics', 2000, 2013, 299.0, 155000000]
]

# Print the dataset in a formatted table
print("Console Sales Data:\n")
for console in console_data:
    for value in console:
        print(f"{value:<20}", end="")
    print()

# Calculate total units sold across all consoles
total_units_sold = 0
for console in console_data:
    total_units_sold += console[5]

print("\nTotal Units Sold Across All Consoles:", total_units_sold)

# Add lifespan (years) as a new column
for console in console_data:
    lifespan = console[3] - console[2]
    console.append(lifespan)

# Add estimated total revenue as a new column
for console in console_data:
    estimated_revenue = console[4] * console[5]
    console.append(estimated_revenue)

# Sort consoles by lifespan (longest to shortest)
console_data_sorted_by_lifespan = sorted(
    console_data,
    key=lambda x: x[6],
    reverse=True
)

print("\nConsoles Sorted by Lifespan (Years):\n")
for console in console_data_sorted_by_lifespan:
    print(
        f"{console[0]:<20}"
        f"Lifespan: {console[6]:<5} years | "
        f"Estimated Revenue: ${console[7]:,.0f}"
    )
