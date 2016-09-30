## ------------------------------------------------------------------------
require(ggplot2)

## ---- fig.height=6, fig.width=6------------------------------------------
# read the data 120420B
# channel B5: sensor=biotin-D1D2/8 micro-mole D1D2 in solusion
# channel C5: sensor=biotin-D1  /8 micro-mole D1D2
# channel D5: sensor=biotin-D2  /8 micro-mole D1D2
filePattern <- "RH120420B"
dirpath <- system.file("extdata", package = "blidata")
filelist <- file.path(dirpath,list.files(dirpath,pattern=filePattern))
datnames <- sapply(list.files(dirpath,pattern=filePattern),
                   simplify=TRUE, USE.NAMES=FALSE,
                   function(x) tools::file_path_sans_ext(x))
len <- length(datnames)
dats <- lapply(filelist, function(file){
    dat <- read.delim(file, skip=4, header=TRUE, sep="\t")})
dats <- setNames(dats,datnames)

plots <- sapply(dats, simplify=FALSE, function(dat){
    g <- radii:::ggplot()
    g <- g + geom_line(data=dat, aes(x=Time1,y=Data1))
    g <- g + xlab("Time (sec)") + ylab("R (nm)")
    g <- g + ggtitle("")
    g
})

# for (i in seq(1,6,by=2)) {
#     ggsave(filename=paste0("Fig01_",i,"s3.tiff"), 
#            plot=plots[[i]],dpi=300,
#            device="tiff", width=3,height=3 )}

## ------------------------------------------------------------------------
# plot the second curve in the data
plots <- lapply(dats, function(dat){
    g <- radii:::ggplot()
    g <- g + geom_line(data=dat, aes(x=Time2, y=Data2))
    # print(g)
    g
})

