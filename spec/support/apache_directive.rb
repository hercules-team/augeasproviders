# frozen_string_literal: true

shared_examples_for 'apache_directive resource' do
  it { is_expected.to have_apache_directive_resource_count(1) }

  it do
    is_expected.to contain_apache_directive('StartServers').only_with('name' => 'StartServers',
                                                                      'ensure'    => 'present',
                                                                      'args'      => '3',
                                                                      'target'    => '/etc/httpd/conf/httpd.conf',
                                                                      'provider'  => 'augeas')
  end
end

shared_context 'apache_directive' do
  it { is_expected.to have_apache_directive_resource_count(0) }

  let :example_params do
    { 'StartServers' => { 'args' => '3', 'target' => '/etc/httpd/conf/httpd.conf' } }
  end

  context 'when apache_directive_hash is a Hash' do
    let(:params) { { apache_directive_hash: example_params } }
    let(:facts) { {} }

    include_examples 'apache_directive resource'
  end

  context 'when ::augeasproviders_apache_directive_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_apache_directive_hash: example_params } }

    include_examples 'apache_directive resource'
  end
end
