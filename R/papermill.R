getRecordOutputType = function() {
  'application/papermill.record+json'
}

#' Record data into Papermill
#'
#' Publishes a mimebundle to Papermills' metadata.
#' 
#' The keys and values that are recorded can be accessed again
#' in another notebook, for example for the purpose of
#' meta analyzing multiple notebooks
#'
#' @param keys a vector of character type. This is used
#' to name the objects stored in value
#' @param value a list of values to record.
#' Limited to characters, logicals, numerics.
#' The list does not have to have homogenous data types.
#' 
#' @importFrom IRdisplay publish_mimebundle
#' @export
#' @examples
#' 
#' \dontrun{
#' keys = letters[1:5]
#' values = as.list(1:5)
#' pm_record(keys, values)
#' }
pm_record = function(keys, values) {
  if (is.list(values)) {
    values = as.list(values)
  }
  if (is.character(keys)) {
    keys = as.character(keys)
  }
  
  recordOutputType = getRecordOutputType()
  mimeBundle = list()
  mimeBundle[[recordOutputType]] = list()
  for (i in seq_along(keys)) {
    k = keys[i]
    v = values[[i]]
    mimeBundle[[recordOutputType]][[k]] = v
  }
  IRdisplay::publish_mimebundle(mimeBundle)
}

#' Papermill Display
#' 
#' Capture the display of an R command.
#' 
#' Obj is any object that can be serialized using
#' \href{https://cran.r-project.org/web/packages/repr/index.html}{repr},
#' for example text, images, and data.frames.
#' If obj is a plot from R's base graphics you must call \code{renderPlot} on it.
#' If obj is a plot from ggplot you must print it then call \code{renderPlot}.
#'
#' @param name an alias for the obj
#' @param obj any object which can be serialized using repr
#' 
#' @export
#' @examples 
#' 
#' \dontrun{
#' plot(1:10)
#' p = recordPlot()
#' pm_display("myplot", p)
#' }
#' 
#' \dontrun{
#' require(ggplot2)
#' df = data.frame(x = 1:5, y = 1:5)
#' myplot = ggplot(df,
#' aes(x = x, y = y)) +
#' geom_point()
#' pm_display("myplot", recordPlot(print(myplot)))
#' }
pm_display = function(name, obj) {
  bundle <- IRdisplay::prepare_mimebundle(obj)
  bundle$metadata[['papermill']] = list(name = name)
  IRdisplay::publish_mimebundle(bundle$data, bundle$metadata)
}
