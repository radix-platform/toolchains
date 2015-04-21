
# Generic rule used for directories

all $(TREEDIRS):

$(TREEDIRS):
	@$(MAKE) FLAVOUR= -C $(TOP_BUILD_DIR_ABS)/$@ $(TREE_RULE)

.PHONY: all $(TREEDIRS)
