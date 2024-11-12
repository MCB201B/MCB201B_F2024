#Let's import our packages all at the beginning
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
import seaborn as sns
import os

#Set up directories as needed using the os package
#Make sure that we're in the correct directory
#We'll want to have it speak to us so we know what's going on
print('Changing to our Week_10 quant directory...\n')
os.chdir('/home/jovyan/MCB201B_F2024/Week_10/quant')
print(f'You are now working in directory {os.getcwd()}\n')

#Make our outputs directory to hold our data
try:
    os.mkdir('counts_qc')
except FileExistsError:
    pass

#Get file name
print('Pulling file names...\n')
data = [name for name in os.listdir() if '.txt' in name]

for file_name in data:
    #Set up our basename based on the file name
    print(f'Assigning a basename for {file_name}...\n')
    basename = file_name.replace('_counts.txt', '')

    #Import our files
    print(f'Importing the counts for {file_name}...\n')
    os.chdir('/home/jovyan/MCB201B_F2024/Week_10/quant')
    counts = pd.read_csv(file_name,
                         delimiter='\t',
                         names=['gene', 
                                'ctrl',
                                'tazko'
                               ]
                        )
    
    #Prepare DataFrame for counts QC
    #This will be for the counts that weren't counted
    read_stats = counts[counts['gene'].str.contains('__')]
    
    #Create a DataFrame for total counts for annotated genes
    counted_reads = counts[~counts['gene'].str.contains('__')].sum(axis=0, numeric_only=True)
    counted_reads = pd.concat([pd.Series({'gene': 'counted_reads'}), counted_reads])
    counted_reads = counted_reads.to_frame().transpose()
    
    #Then concatentate the total reads to the reads that weren't counted
    read_stats = pd.concat([read_stats, counted_reads], ignore_index=True)
    
    #Let's update the gene column to remove the '__'
    updated_label = []
    for new_label in read_stats['gene']:
        updated_label.append(new_label.replace('__', ''))
    read_stats['gene'] = updated_label

    #Update index to be the gene column
    read_stats = read_stats.set_index('gene')
    #Transpose our dataframe for our stacked bar plot
    read_stats = read_stats.transpose()

    print('Creating a stacked bar plot...\n')
    #First set up your subplots
    fig, ax = plt.subplots()
    
    #Define what our x-axis is going to be - in our case it's either ctrl or tazko
    x=read_stats.index
    
    #Define what our y-axis is going to be - in our case it's our column headers
    y=read_stats.columns[::-1]
    
    #Set up an array of zeros to hold data for our for loop
    bottom=np.zeros(len(x))
    
    #Set up a lazy way to pick colors since we don't care too much about the number of colors we need
    use_color=pd.Series(mcolors.CSS4_COLORS)
    
    #Set up our for loop to plot a stacked bar plot
    for i in np.arange(0, len(y), 1):
        #This is for plotting our stacked bar plot
        plt.bar(x,
                read_stats[y[i]],
                label=y[i],
                bottom=bottom,
                color=use_color[125+i*4],
                lw=0.25,
                edgecolor='k'
               )
        bottom += read_stats[y[i]]
    
    #Pretty up our plots
    plt.title('Counts QC')
    plt.ylabel('Read counts (1e6 bp)')
    plt.xticks([0,1],
               ['Control', '$TAZ$ KO']
              )
    plt.legend(loc='center',
               bbox_to_anchor=(1.25,0.5),
               fontsize=5,
               edgecolor='white'
              )
    sns.despine()
    
    fig.set_dpi(300)
    fig.set_size_inches(2,3)
    
    #Export our plot as a PDF into our counts_qc folder
    os.chdir('/home/jovyan/MCB201B_F2024/Week_10/quant/counts_qc')
    fig.savefig(basename+'_counts_qc_stacked_bar.pdf', bbox_inches='tight')

    #Begin with a manual analysis of our data and we'll also export a csv of our counts
    just_counts = counts[~counts['gene'].str.contains('__')]
    os.chdir('/home/jovyan/MCB201B_F2024/Week_10/quant')
    just_counts.to_csv(basename+'_gene_counts.csv', index=False)

    #Getting the ratio and the average and saving it into a new column
    just_counts['ratio'] = just_counts['tazko'] / just_counts['ctrl']
    just_counts['avg'] = (just_counts['tazko'] + just_counts['ctrl']) / 2

    #Identify the downregulated and the upregulated genes
    downreg = just_counts[(0.5 >= just_counts['ratio'])]
    upreg = just_counts[(2 <= just_counts['ratio'])]

    #Set up the scatter plot for our single replicate
    fig, ax = plt.subplots()
    
    sns.lineplot(x=[1, 10000],
                 y=[2, 20000],
                 lw=0.25,
                 ls='--',
                 c='grey'
                )
    
    sns.lineplot(x=[1, 10000],
                 y=[0.5, 5000],
                 lw=0.25,
                 ls='--',
                 c='grey'
                )
    
    sns.scatterplot(x=just_counts['ctrl'],
                    y=just_counts['tazko'],
                    c='grey',
                    s=6
                   )
    
    sns.scatterplot(x=upreg['ctrl'],
                    y=upreg['tazko'],
                    c='r',
                    s=6
                   )
    
    sns.scatterplot(x=downreg['ctrl'],
                    y=downreg['tazko'],
                    c='b',
                    s=6
                   )
    
    plt.loglog()
    plt.title('Scatter plot of raw read counts')
    plt.xlabel('Control')
    plt.ylabel('$TAZ$ KO')
    sns.despine()
    
    fig.set_dpi(300)
    fig.set_size_inches(4,4)
    
    os.chdir('/home/jovyan/MCB201B_F2024/Week_10/quant/counts_qc')
    fig.savefig(basename+'_scatterplot.pdf', bbox_inches='tight')

    fig, ax = plt.subplots()
    
    sns.lineplot(x=[1, 10000],
                 y=[2, 2],
                 lw=0.25,
                 ls='--',
                 c='grey'
                )
    
    sns.lineplot(x=[1, 10000],
                 y=[0.5, 0.5],
                 lw=0.25,
                 ls='--',
                 c='grey'
                )
    
    sns.scatterplot(x=just_counts['avg'],
                    y=just_counts['ratio'],
                    c='grey',
                    s=6
                   )
    
    sns.scatterplot(x=upreg['avg'],
                    y=upreg['ratio'],
                    c='r',
                    s=6
                   )
    
    sns.scatterplot(x=downreg['avg'],
                    y=downreg['ratio'],
                    c='b',
                    s=6
                   )
    
    plt.loglog()
    plt.title('MA plot')
    plt.xlabel('Average')
    plt.ylabel('Ratio')
    sns.despine()
    
    fig.set_dpi(300)
    fig.set_size_inches(4,4)

    fig.savefig(basename+'_MAplot.pdf', bbox_inches='tight')

print('Done!')