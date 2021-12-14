use tide::Request;

#[async_std::main]
async fn main() -> tide::Result<()> {
    tide::log::start();
    let mut app = tide::new();
    app.at("/").get(hello);
    app.listen("0.0.0.0:8080").await?;
    Ok(())
}

async fn hello(mut req: Request<()>) -> tide::Result {
    Ok(format!("Hello").into())
}
