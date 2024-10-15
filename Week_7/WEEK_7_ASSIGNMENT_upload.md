<h1 style="font-size: 40px; margin-bottom: 0px;">Week 7 Assignment</h1>

<hr style="margin-left: 0px; border: 0.25px solid; border-color: #000000; width: 100%;"></hr>

<p><strong><u>Due: <mark>Wednesday, October 23 at 11:59PM</mark></u></strong></p>

<p><strong><u>Total points: 5 pts</u></strong></p>

<p><strong><u>To turn in your assignment:</u></strong></p>

<ol>
    <li>Complete assignment and make sure you have all the outputs requested</li>
    <li>Go to your server's file directory and locate the folder containing your output files for this week's assignment</li>
    <li>Right click and select <strong>Download as an Archive</strong> to download each output</li>
    <ul>
        <li>The folder should download as a .zip file</li>
    </ul>
    <li>Navigate to lab class <u><strong><a href="https://drive.google.com/drive/folders/1Limmo19dvhZz3qIaDDSnuSrl44yTiHUd?usp=sharing" rel="noopener noreferrer" target="_blank">Google Drive</a></strong></u></li>
    <li>Find your individual folder in the <strong>Assignment Submission folder</strong></li>
    <li>Upload this week's folder (keep it zipped)</li>
</ol>

<p><strong><u>How this assignment will be graded:</u></strong></p>

<p>This assignment will make use of Terminal, but some things can be done in the File Browser if you wish. You will be graded on whether or not you have the correct outputs.</p>


<h1 style="font-size: 40px; margin-bottom: 0px;">Question 1</h1>

<p style="margin-top: 15px;">Ungraded</p>

<hr style="margin-left: 0px; border: 0.25px solid; border-color: #EEEEEE; width: 100%;"></hr>

<p>In your Week_7 directory, create a new directory called <code>week_7_outputs</code>. This will be where you will save your outputs for this week's assignment.</p>


<h1 style="font-size: 40px; margin-bottom: 0px;">Question 2</h1>

<p style="margin-top: 15px;">1 pt</p>

<hr style="margin-left: 0px; border: 0.25px solid; border-color: #EEEEEE; width: 100%;"></hr>

<p>Align the following .fastq.gz files to the hg19 reference genome using bowtie2. Please do not submit your SAM/BAM files (they are huge...)</p>

<ul>
    <li>ctrl_1.fastq.gz</li>
    <li>ctrl_2.fastq.gz</li>
    <li>taz_1.fastq.gz</li>
    <li>taz_2.fastq.gz</li>
</ul>

<p>Redirect the first 10 lines of the four SAM files into a .txt file (one for each SAM file). Save the .txt files into the <code>week_7_outputs</code> folder to be submitted.</p>

<h1 style="font-size: 40px; margin-bottom: 0px;">Question 3</h1>

<p style="margin-top: 15px;">1 pt</p>

<hr style="margin-left: 0px; border: 0.25px solid; border-color: #EEEEEE; width: 100%;"></hr>

<p>Call peaks for your control files (pooled together) using macs2. Run the resulting R script file (file has the extension <code>.r</code>) to obtain a PDF of the shift and cross-correlation plots. Save the PDF output into <code>week_7_outputs</code>. You do not need to turn in the other outputs.</p>

<h1 style="font-size: 40px; margin-bottom: 0px;">Question 4</h1>

<p style="margin-top: 15px;">1 pt</p>

<hr style="margin-left: 0px; border: 0.25px solid; border-color: #EEEEEE; width: 100%;"></hr>

<p>Call peaks for taz_1 and taz_2 (not pooled) using macs2 and set the control as your control files (pooled together). Run the resulting R script files for both taz_1 and taz_2 to obtain a PDF of the shift and cross-correlation plots. Save the two PDF outputs into <code>week_7_outputs</code>. You do not need to turn in the other outputs.</p>

<h1 style="font-size: 40px; margin-bottom: 0px;">Question 5</h1>

<p style="margin-top: 15px;">1 pt</p>

<hr style="margin-left: 0px; border: 0.25px solid; border-color: #EEEEEE; width: 100%;"></hr>

<p>Load your taz_1 and taz_2 <code>.xls</code> files into Python, like we did in class, and create a new .csv file containing just the top 5 most significant peaks (one .csv file for taz_1 and one for taz_2) according to the -log10(qvalue). Save the .csv outputs into <code>week_7_outputs</code>. You do not need to submit the full .xls files.</p>

<h1 style="font-size: 40px; margin-bottom: 0px;">Question 6</h1>

<p style="margin-top: 15px;">1 pt</p>

<hr style="margin-left: 0px; border: 0.25px solid; border-color: #EEEEEE; width: 100%;"></hr>

<p>Using IGV, load in your <code>taz_1_peaks.narrowPeaks</code> file and your <code>taz_1_treat_pileup.bdg</code> for taz_1. Then load in your <code>ctrl_treat_pileup.bdg</code> into IGV as well. Find the most differentially expressed peak for taz_1. Adjust the data range for both .bdg tracks to be the same. Save your view as a PNG. Place the PNG file into your <code>week_7_outputs</code> directory.</p>
