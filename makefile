#sectional, enroute, tac, wac, heli, grand_canyon
CHARTTYPE = tac

ORIGINALDIR =./original
LINKDIR =./sourceRasters/$(CHARTTYPE)
SHAPEDIR =./clippingShapes/$(CHARTTYPE)
EXPANDEDDIR =./expandedRasters/$(CHARTTYPE)
WARPEDDIR =./warpedRasters/$(CHARTTYPE)
CLIPPEDDIR =./clippedRasters/$(CHARTTYPE)
MBTILESDIR =./mbtiles/$(CHARTTYPE)

#Root directory of where the aeronav charts are mirrored to
chartsRoot=/media/sf_Shared_Folder/charts/

#Where the original .tif files of various types are from aeronav
originalHeliDirectory="$(chartsRoot)/aeronav.faa.gov/content/aeronav/heli_files/"
originalTacDirectory="$(chartsRoot)/aeronav.faa.gov/content/aeronav/tac_files/"
originalWacDirectory="$(chartsRoot)/aeronav.faa.gov/content/aeronav/wac_files/"
originalSectionalDirectory="$(chartsRoot)/aeronav.faa.gov/content/aeronav/sectional_files/"
originalGrandCanyonDirectory="$(chartsRoot)/aeronav.faa.gov/content/aeronav/grand_canyon_files/"
originalEnrouteDirectory="$(chartsRoot)/aeronav.faa.gov/enroute/01-08-2015/"

#Root of directories where our processed images etc will be saved
destinationRoot=/home/jlmcgraw/Documents/myPrograms/mergedCharts


LINKS    = $(wildcard $(LINKDIR)/*.tif)
SHAPES   = $(patsubst $(LINKDIR)/%.tif,$(SHAPEDIR)/%.shp,$(LINKS)) 
EXPANDED = $(patsubst $(LINKDIR)/%.tif,$(EXPANDEDDIR)/%.tif,$(LINKS))
WARPED   = $(patsubst $(LINKDIR)/%.tif,$(WARPEDDIR)/%.tif,$(LINKS)) 
CLIPPED  = $(patsubst $(LINKDIR)/%.tif,$(CLIPPEDDIR)/%.tif,$(LINKS)) 
MBTILES   = $(patsubst $(LINKDIR)/%.tif,$(MBTILESDIR)/%.mbtiles,$(LINKS)) 

all: FRESHEN LINKS $(MBTILES) ALLCHARTS
# 	@echo $(LINKS)
# 	@echo $(SHAPES)
# 	@echo $(EXPANDED)
# 	@echo $(CLIPPED)
	
$(MBTILES): $(MBTILESDIR)/%.mbtiles: $(CLIPPEDDIR)/%.tif
	@echo Build MBTILE: $@
	@echo Changed Dendencies: $?
	@echo Current Dependency: $< 
# 	touch $@
# 	rm $@ 
#@echo ./enroute.sh     $(originalEnrouteDirectory)     $(destinationRoot) $@
	@echo ----------------------------------------------------------------------------------------
	
$(CLIPPED): $(CLIPPEDDIR)/%.tif: $(SHAPEDIR)/%.shp $(WARPEDDIR)/%.tif
# $(CLIPPED): $(SHAPES) $(EXPANDED)
	@echo Build CLIPPED: $@
	@echo Changed Dendencies: $?
	@echo Current Dependency: $< 
# 	touch $@
# 	rm $@ 
#@echo ./enroute.sh     $(originalEnrouteDirectory)     $(destinationRoot) $@
	@echo ----------------------------------------------------------------------------------------

$(WARPED):  $(WARPEDDIR)/%.tif: $(LINKDIR)/%.tif
# $(EXPANDED):  $(LINKDIR)/%.tif
	@echo Build WARP: $@
	@echo Changed Dendencies: $?
	@echo Current Dependency: $<
#BUG TODO Enroute charts don't have to be expanded
# 	rm $@
	@echo ./warpClip.sh
	
$(EXPANDED):  $(EXPANDEDDIR)/%.tif: $(LINKDIR)/%.tif
# $(EXPANDED):  $(LINKDIR)/%.tif
	@echo Build EXPAND: $@
	@echo Changed Dendencies: $?
	@echo Current Dependency: $<
#BUG TODO Enroute charts don't have to be expanded
	@echo ./translateExpand.sh
	@echo rm $@

$(SHAPES):  $(SHAPEDIR)/%.shp: $(LINKDIR)/%.tif
	@echo Build SHAPE: $@
	@echo Changed Dendencies: $?
	@echo Current Dependency: $< 
# 	touch $@

$(LINKS):  
	@echo Build LINK: $@
	@echo Changed Dendencies: $?
	@echo Current Dependency: $< 
# 	@touch $@
	
FRESHEN:
# 	./freshenLocalCharts.sh $(chartsRoot)

LINKS:
# 	./updateLinks.sh $(originalEnrouteDirectory) $(destinationRoot) $(CHARTTYPE)
	
ALLCHARTS:
# 	./allcharts.sh
# .PHONY: $(SHAPES) $(LINKS)

# $(CLIPPEDDIR)/%.tif: $(SHAPEDIR)/%.shp $(EXPANDEDDIR)/%.tif
# # 	$(CC) -c -o $@ $< $(CFLAGS)
# 	echo $@ $< $
# 	echo $(LINKS)
# 	echo $(SHAPES)
	
# hellomake: $(OBJ)
# 	gcc -o $@ $^ $(CFLAGS) $(LIBS)
# 
# .PHONY: clean
# 
# clean:
# 	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ 